//
//  EmojiMemoryGameThemes.swift
//  Memorize
//
//  Created by Doğan Mert Güven on 27.05.2020.
//  Copyright © 2020 Doğan Mert Güven. All rights reserved.
//

import SwiftUI

public var themes: [Theme] = [
    Theme(name: "Flags",
          setOfEmoji: ["🇬🇧","🇺🇸","🇹🇷","🇨🇦","🇯🇵","🇩🇪","🇳🇴","🇨🇿","🇦🇹",
                       "🇭🇺","🇳🇱","🇫🇷","🇵🇱","🇧🇷","🇮🇪","🇳🇴","🇧🇪","🇷🇺"],
          accentColor: Color.blue,
          numberOfPairs: 9),
    
    Theme(name: "Food",
          setOfEmoji: ["🍔","🍕","🍝","🧆","🍦","🍿","🍫","🍣","🌮",
                       "🥪","🍗","🥓","🥨","🧀","🍞","🍳","🥞","🥗"],
          accentColor: Color.green,
          numberOfPairs: nil),
    
    Theme(name: "Halloween",
          setOfEmoji: ["👻","🎃","🙀","😈","☠️","💀","🦇","🍭","🕸",
                       "🕷"],
          accentColor: Color.orange,
          numberOfPairs: nil),
    
    Theme(name: "Places",
          setOfEmoji: ["🏢","🏤","🏥","🏦","🏨","🏪","🏫","🏛","⛪️",
                       "🕌","🕍","🛕","⛩"],
          accentColor: Color.purple,
          numberOfPairs: nil),
    
    Theme(name: "Vehicles",
          setOfEmoji: ["🚗","🚕","🏎","🚜","🚚","🚆","🚊","🛩","🚀",
                       "🚁","🛸","🚤","⛵️"],
          accentColor: Color.red,
          numberOfPairs: nil),
    
    Theme(name: "Faces",
          setOfEmoji: ["😄","😅","😂","😇","😍","😘","😋","😜","🤓",
                       "😎","🥺","🤬","🤯","🥶","🤢","😷","👽"],
          accentColor: Color.yellow,
          numberOfPairs: nil),
]

public struct Theme {
    let name: String
    let setOfEmoji: [String]
    let accentColor: Color
    let numberOfPairs: Int?
}
