//
//  EmojiGameMemorize.swift
//  Memorize
//
//  Created by Stefan Crudu on 02.03.2023.
//

import SwiftUI

class EmojiMemorizeGame: ObservableObject {
    private let themes: [Theme<String>] = [
        .init(name: "Electronics", contentList: ["💻", "🖥️", "⌚️", "💾", "🎥", "🕹️", "📼", "⌨️", "📷", "📺", "📟", "📠", "☎️"], color: .init(name: "orange")),
        .init(name: "Animals", contentList: ["🐶", "🐱", "🐹", "🐯", "🐭", "🐸", "🐼", "🐻"],contentLengthToShow: .number(7), color: .init(name: "green", isGradient: true)),
        .init(name: "People", contentList: ["👮🏼‍♀️", "🕵️", "👩‍⚕️", "👷‍♂️", "💂", "👨‍🌾", "👨‍🎨", "👨‍🔧", "🧑‍💻", "👨‍🏭", "🧑‍🍳", "🧑‍🏫"], color:  .init(name: "red")),
        .init(name: "Flags", contentList: ["🇩🇿", "🇧🇪", "🇧🇯", "🇹🇩", "🇫🇮", "🇳🇴", "🇫🇷", "🇬🇷", "🇺🇸"], contentLengthToShow: .random, color: .init(name: "green", isGradient: true)),
        .init(name: "Vehicles", contentList: ["🚜", "🚅", "🛩️", "🚔", "🏍️", "🚑", "🚌", "🛸", "🚆", "🛳️", "🚋", "🚲", "🛴"], color:  .init(name: "pink", isGradient: true)),
        .init(name: "Food", contentList: ["🍊", "🥔", "🍇", "🍞", "🍑", "🥬", "🍍", "🍌", "🥐", "🥐"], contentLengthToShow: .number(20),color:  .init(name: "yellow"))
    ]
    @Published private var memoryGame: MemoryGame<String>!
    @Published var theme: Theme<String>! {
        didSet {
            memoryGame = createMemoryGame(with: theme)
        }
    }
    var cards: [MemoryGame<String>.Card] {
        memoryGame.cards
    }
    var score: Int {
        memoryGame.score
    }
    
    var colorTheme: Color {
        getColor(theme.color.name)
    }
    
    var colorGradient: AnyGradient? {
        return theme.color.isGradient ? getColor(theme.color.name).gradient : nil
    }
    
    init() {
        setNewTheme()
        memoryGame = createMemoryGame(with: theme)
    }
}

//MARK: - Intent(s)
extension EmojiMemorizeGame {
    func setNewTheme() {
        guard let newTheme = themes.randomElement() else { fatalError("We don't have the theme.") }
        theme = newTheme
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        memoryGame.chooseCard(card)
    }
}

//MARK: - Private
private extension EmojiMemorizeGame {
    private func createMemoryGame(with theme: Theme<String>) -> MemoryGame<String> {
        return .init(numberOfCards: theme.contentLengthToShow, contentCard: { index in
            Array(theme.contentList)[index]
        })
    }
    
    private func getColor(_ stringColor: String?) -> Color {
        switch stringColor {
        case "orange":
            return Color.orange
        case "green":
            return Color.green
        case "red":
            return Color.red
        case "blue":
            return Color.blue
        case "pink":
            return Color.pink
        case "yellow":
            return Color.yellow
        case "brown":
            return Color.brown
        case "cyan":
            return Color.cyan
        case "indigo":
            return Color.indigo
        case "purple":
            return Color.purple
        default:
            return Color.gray
        }
    }
}
