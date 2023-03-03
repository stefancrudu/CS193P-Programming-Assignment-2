//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Stefan Crudu on 02.03.2023.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var viewModel = EmojiMemorizeGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
