//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Doğan Mert Güven on 1.07.2020.
//  Copyright © 2020 Doğan Mert Güven. All rights reserved.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame())
        }
    }
}
