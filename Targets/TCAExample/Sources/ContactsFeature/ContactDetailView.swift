//
//  ContactDetailView.swift
//  TCAExample
//
//  Created by wickedRun on 2023/06/23.
//  Copyright © 2023 org.wickedrun. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct ContactDetailView: View {
    let store: StoreOf<ContactDetailFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Form {
                Button("Delete") {
                    viewStore.send(.deleteButtonTapped)
                }
            }.navigationTitle(Text(viewStore.contact.name))
        }
        .alert(store: self.store.scope(state: \.$alert, action: { .alert($0) }))
    }
}

struct ContactDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(
            initialState: ContactDetailFeature.State(
                contact: Contact(
                    id: UUID(),
                    name: "Blob")
            )
        ) {
            ContactDetailFeature()
        }
        
        NavigationStack {
            ContactDetailView(store: store)
        }
    }
}
