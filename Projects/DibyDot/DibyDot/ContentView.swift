//
//  ContentView.swift
//  DibyDot
//
//  Created by kirby on 4/16/25.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: DibyDotDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

#Preview {
    ContentView(document: .constant(DibyDotDocument()))
}
