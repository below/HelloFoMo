//
//  BorderedTextView.swift
//  HelloFoMo
//
//  Created by Alexander von Below on 25.08.25.
//

import SwiftUI

struct BorderedTextView: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.accentColor, lineWidth: 2)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    BorderedTextView("Hello, World!")
}
