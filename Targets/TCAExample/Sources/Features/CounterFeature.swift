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
    }
    
    enum Action {
        case decrementButtonTapped
        case factButtonTapped
        case incrementButtonTapped
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .decrementButtonTapped:
            state.count -= 1
            state.fact = nil
            return .none
            
        case .factButtonTapped:
            state.fact = nil
            state.isLoading = true

            // 이 방법으로는 concurrency를 지원하지 않는 function은 async 호출 불가능하고 에러 처리 불가능하므로 적절한 방법이 아니다.
            let (data, _) = try await URLSession.shared.data(from: URL(string: "http://numbersapi.com/\(state.count)")!)

            state.fact = String(decoding: data, as: UTF8.self)
            state.isLoading = false
            
            return .none
            
        case .incrementButtonTapped:
            state.count += 1
            state.fact = nil
            return .none
        }
    }
    
}

// Equatable을 이 파일 밖에서 extension으로 채택해주려면 직접 구현해주어야 한다.
extension CounterFeature.State: Equatable { }
