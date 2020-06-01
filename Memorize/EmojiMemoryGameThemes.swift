//
//  EmojiMemoryGameThemes.swift
//  Memorize
//
//  Created by Doğan Mert Güven on 27.05.2020.
//  Copyright © 2020 Doğan Mert Güven. All rights reserved.
//

import SwiftUI

// Assignment 2 Task 6
public let themes: [Theme] = [
    Theme(
        name: "Flags",
        setOfEmoji: ["🇬🇧", "🇺🇸", "🇹🇷", "🇨🇦", "🇯🇵", "🇩🇪", "🇳🇴", "🇨🇿", "🇦🇹", "🇭🇺", "🇳🇱", "🇫🇷", "🇵🇱", "🇧🇷", "🇮🇪", "🇳🇴", "🇧🇪", "🇷🇺"],
        accentColor: .blue,
        numberOfPairs: 9,
        id: 0
    ),
    
    Theme(
        name: "Food",
        setOfEmoji: ["🍔", "🍕", "🍝", "🧆", "🍦", "🍿", "🍫", "🍣", "🌮", "🥪", "🍗", "🥓", "🥨", "🧀", "🍞", "🍳", "🥞", "🥗"],
        accentColor: .green,
        numberOfPairs: nil,
        id: 1
    ),
    
    Theme(
        name: "Halloween",
        setOfEmoji: ["👻", "🎃", "🙀", "😈", "☠️", "💀", "🦇", "🍭", "🕸", "🕷"],
        accentColor: .orange,
        numberOfPairs: nil,
        id: 2
    ),
    
    Theme(
        name: "Places",
        setOfEmoji: ["🏢", "🏤", "🏥", "🏦", "🏨", "🏪", "🏫", "🏛", "⛪️", "🕌", "🕍", "🛕", "⛩"],
        accentColor: .purple,
        numberOfPairs: nil,
        id: 3
    ),
    
    Theme(
        name: "Vehicles",
        setOfEmoji: ["🚗", "🚕", "🏎", "🚜", "🚚", "🚆", "🚊", "🛩", "🚀", "🚁", "🛸", "🚤", "⛵️"],
        accentColor: .red,
        numberOfPairs: nil,
        id: 4
    ),
    
    Theme(
        name: "Faces",
        setOfEmoji: ["😄", "😅", "😂", "😇", "😍", "😘", "😋", "😜", "🤓", "😎", "🥺", "🤬", "🤯", "🥶", "🤢", "😷", "👽"],
        accentColor: .yellow,
        numberOfPairs: nil,
        id: 5
    ),
]

// Assignment 2 Task 3
public struct Theme: Identifiable {
    let name: String
    let setOfEmoji: [String]
    let accentColor: Color
    let numberOfPairs: Int?
    public let id: Int
}
