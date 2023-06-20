//
//  AddContactView.swift
//  TCAExample
//
//  Created by wickedRun on 2023/06/20.
//  Copyright © 2023 org.wickedrun. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct AddContactView: View {
    let store: StoreOf<AddContactFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Form {
                TextField("Name", text: viewStore.binding(get: \.contact.name, send: { .setName($0) }))
                Button("Save") {
                    viewStore.send(.saveButtonTapped)
                }
            }.toolbar {
                ToolbarItem {
                    Button("Cancel") {
                        viewStore.send(.cancelButtonTapped)
                    }
                }
            }
        }
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddContactView(
                store: Store(
                    initialState: AddContactFeature.State(
                        contact: Contact(
                            id: UUID(),
                            name: "Blob"
                        )
                    ),
                    reducer: AddContactFeature()
                )
            )
        }
    }
}
