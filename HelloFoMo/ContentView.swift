//
//  ContentView.swift
//  HelloFoMo
//
//  Created by Alexander von Below on 25.08.25.
//

import SwiftUI
import FoundationModels

struct ContentView: View {
    let session: LanguageModelSession
    @State var conversation: Conversation = []
    @State var prompt: String = ""
    @State var error: String?
    @State var isProcessing: Bool = false
    
    private func processPrompt(_ prompt: String) {
        isProcessing = true
        Task {
            let response = try await self.session.respond(to: self.prompt)
            DispatchQueue.main.async {
                self.conversation.append(.init(prompt: self.prompt, response: response.content))
                self.prompt = ""
                self.isProcessing = false
            }
        }
    }
    
    var body: some View {
        VStack {
                ConversationView(conversation)
            TextField("Ask me anything", text: $prompt)
                .onSubmit {
                    processPrompt(prompt)
                }
                .disabled(isProcessing)
            HStack {
                Spacer()
                Button("Ask") {
                    processPrompt(prompt)
                }
                .disabled(isProcessing)
                Spacer()
                let conversationText = conversation.map { "\($0.prompt)\n\($0.response)\n" }.joined(separator: "\n")
                ShareLink(item: conversationText)
                    .disabled(conversation.isEmpty)
            }
        }
        .padding()
    }
}

#Preview {
    let session = LanguageModelSession()
    ContentView(session: session)
}
