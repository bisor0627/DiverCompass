//
//  DibyDotApp.swift
//  DibyDot
//
//  Created by kirby on 4/16/25.
//

import SwiftUI

@main
struct DibyDotApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: DibyDotDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
