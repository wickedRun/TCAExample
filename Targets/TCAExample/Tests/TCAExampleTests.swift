import Foundation
import XCTest

@testable import TCAExample
import ComposableArchitecture

@MainActor
final class TCAExampleTests: XCTestCase {
    func testCounter() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        // 이렇게 테스트를 하면 send를 하기 전과 후의 상태가 바뀌어서 에러를 내뿜게 되며,
        // - 부분이 예측한 상태이고
        // + 부분이 실제 값이므로
        // 아래 에러메시지 예시에서 -의 count값과 +의 count값이 다르기 때문에 테스트 실패가 된다.
        /*
         estCounter(): State was not expected to change, but a change occurred: …

               CounterFeature.State(
             −   count: 0,
             +   count: 1,
                 fact: nil,
                 isLoading: false,
                 isTimerRunning: false
               )

         (Expected: −, Actual: +)
         */
        await store.send(.incrementButtonTapped)
        await store.send(.decrementButtonTapped)
    }
}
