//
//  CounterFeature.swift
//  TCAExample
//
//  Created by wickedRun on 2023/06/16.
//  Copyright © 2023 org.wickedrun. All rights reserved.
//

import Foundation

import ComposableArchitecture

struct CounterFeature: ReducerProtocol {
    struct State {
        var count = 0
        var fact: String?
        var isLoading = false
        var isTimerRunning = false
    }
    
    enum Action {
        case decrementButtonTapped
        case factButtonTapped
        case factResponse(String)
        case incrementButtonTapped
        case timerTick
        case toggleTimerButtonTapped
    }
    
    enum CancelID { case timer }
    
    @Dependency(\.continuousClock) var clock
    @Dependency(\.numberFact) var numberFact
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .decrementButtonTapped:
            state.count -= 1
            state.fact = nil
            return .none
            
        case .factButtonTapped:
            state.fact = nil
            state.isLoading = true

            return .run { [count = state.count] send in
                // count 값을 캡쳐링 하는 이유:
                // Mutable capture of 'inout' parameter 'state' is not allowed in concurrently-executing code
                // concurrently-executing 코드에서는 inout 매개변수의 mutable 캡쳐는 불가능하다.
                // 그래서 값이 일정하도록 캡쳐링한다.
                
                try await send(.factResponse(self.numberFact.fetch(count)))
                // 이렇게 따로 send를 호출하는 이유도 마찬가지로 state를 쓸 수 없기 때문에 다시 reduce를 통해서 하도록 한다.
            }
            
        case let .factResponse(fact):
            state.fact = fact
            state.isLoading = false
            return .none
            
        case .incrementButtonTapped:
            state.count += 1
            state.fact = nil
            return .none
            
        case .timerTick:
            state.count += 1
            state.fact = nil
            return .none
            
        case .toggleTimerButtonTapped:
            state.isTimerRunning.toggle()
            
            if state.isTimerRunning {
                return .run { send in
                    for await _ in self.clock.timer(interval: .seconds(1)) {
                        await send(.timerTick)
                    }
                }
                .cancellable(id: CancelID.timer)
            } else {
                return .cancel(id: CancelID.timer)
            }
        }
    }
    
}

// Equatable을 이 파일 밖에서 extension으로 채택해주려면 직접 구현해주어야 한다.
extension CounterFeature.State: Equatable { }

extension CounterFeature.Action: Equatable { }
