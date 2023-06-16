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
    }
    
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .decrementButtonTapped:
            state.count -= 1
            return .none
            
        case .incrementButtonTapped:
            state.count += 1
            return .none
        }
    }
    
}

// Equatable을 이 파일 밖에서 extension으로 채택해주려면 직접 구현해주어야 한다.
extension CounterFeature.State: Equatable { }
