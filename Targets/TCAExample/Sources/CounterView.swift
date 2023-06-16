//
//  CounterView.swift
//  TCAExample
//
//  Created by wickedRun on 2023/06/16.
//  Copyright © 2023 org.wickedrun. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct CounterView: View {
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            
            VStack {
                Text("\(viewStore.count)")
                    .customBackground()
                
                HStack {
                    Button("-") {
                        viewStore.send(.decrementButtonTapped)
                    }
                    .customBackground()
                    
                    Button("+") {
                        viewStore.send(.incrementButtonTapped)
                    }
                    .customBackground()
                }
                
                Button("Fact") {
                    viewStore.send(.factButtonTapped)
                }
                .customBackground()
                
                if viewStore.isLoading {
                    ProgressView()
                } else if let fact = viewStore.fact {
                    Text(fact)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
        }
    }
}

struct CustomBackground: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
    }
}

private extension View {
    
    func customBackground() -> some View {
        modifier(CustomBackground())
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(
            store: Store(initialState: CounterFeature.State()) {
                CounterFeature()
            }
        )
    }
}
