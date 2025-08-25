//
//  HelloFoMoApp.swift
//  HelloFoMo
//
//  Created by Alexander von Below on 25.08.25.
//

import SwiftUI
import FoundationModels

@main
struct HelloFoMoApp: App {
    let model = SystemLanguageModel(guardrails: .permissiveContentTransformations)

    var body: some Scene {
        WindowGroup {
            if case .available = model.availability {
                ContentView(session: LanguageModelSession(model: model))
            } else {
                Text("Apple Intelligence is not available.")
                    .foregroundStyle(Color.red)
            }
        }
    }
}
