import SwiftUI

import ComposableArchitecture

@main
struct TCAExampleApp: App {
    // 응용프로그램을 구동하는 Store는 한 번만 만들어야 한다는 점에 유의해야 합니다.
    // 대부분의 경우 WindowGroup에서 직접 만들어도 충분하지만,
    // 정적 변수로 유지한 다음 WindowGroup에서 넣어줄 수도 있습니다.
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    
    static let contactsStore = Store(initialState: ContactsFeature.State(contacts: [
        Contact(id: UUID(), name: "Blob"),
        Contact(id: UUID(), name: "Blob Jr"),
        Contact(id: UUID(), name: "Blob Sr")
    ])) {
        ContactsFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            ContactsView(store: TCAExampleApp.contactsStore)
        }
    }
}
