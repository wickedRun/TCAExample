//
//  CounterFeatureTests.swift
//  TCAExampleTests
//
//  Created by wickedRun on 2023/06/17.
//  Copyright © 2023 org.wickedrun. All rights reserved.
//

import Foundation
import XCTest

@testable import TCAExample
import ComposableArchitecture

@MainActor
final class CounterFeatureTests: XCTestCase {
    
    func testNumberFact() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.numberFact.fetch = { "\($0) is a good number." }
        }
        
        await store.send(.factButtonTapped) {
            $0.isLoading = true
        }
        
        await store.receive(.factResponse("0 is a good number."), timeout: .seconds(1)) {
            $0.isLoading = false
            $0.fact = "0 is a good number."
        }
    }
    
    func testTimer() async {
        let clock = TestClock()
        
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }
        
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = true
        }
        // 위에 Action만 보내면 action이 끝나지 않는다.
        // ❌ An effect returned for this action is still running.
        //    It must complete before the end of the test. …
        
        await clock.advance(by: .seconds(1))
        await store.receive(.timerTick, timeout: .seconds(2)) {
            $0.count = 1
        }
        
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = false
        }
    }
    
    func testCounter() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        // 올바른 send 방법
        // 후행 클로저를 통해
        // 입력값은 보내기전에 State가 들어오며,
        // 해당 Action이 전송된 후에 기대한 State와 동일하도록 작성해주면 된다.
        // 작성 Tip
        // 상대 변화인 $0.count += 1 보다는 $0.count = 1과 같은 절대 변화를 사용하는 것이 좋다.
        // 단순히 어떤 변환이 State에 적용되었는지보다 feature의 정확한 State를 알고 있음을 증명하는 더 강력한 assertion입니다.
        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }
        
        await store.send(.decrementButtonTapped) {
            $0.count = 0
        }
    }
}
