//
//  ConversationView.swift
//  HelloFoMo
//
//  Created by Alexander von Below on 25.08.25.
//

import SwiftUI

struct SimpleConversation {
    let prompt: String
    let response: String
}
typealias Conversation = [SimpleConversation]

struct ConversationView: View {
    public init(_ conversations: Conversation) {
        self.conversations = conversations
    }
    
    let conversations: Conversation
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(Array(conversations.enumerated()), id: \.offset) { idx, conv in
                        HStack {
                            BorderedTextView(conv.prompt)
                            Spacer()
                        }
                        .id(idx * 2)
                        HStack {
                            Spacer()
                            BorderedTextView(conv.response)
                        }
                        .id(idx * 2 + 1)
                    }
                }
                .padding()
            }
            .onChange(of: conversations.count) { _, newCount in
                if newCount > 0, let last = conversations.indices.last {
                    withAnimation {
                        proxy.scrollTo(last * 2 + 1, anchor: .bottom)
                    }
                }
            }
        }
    }
}

#Preview {
    let conversation: Conversation = [SimpleConversation(prompt: "Hello", response: "World")]
    ConversationView(conversation)
}
