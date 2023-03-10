//
//  EmojiGameMemorize.swift
//  Memorize
//
//  Created by Stefan Crudu on 02.03.2023.
//

import SwiftUI

class EmojiMemorizeGame: ObservableObject {
    private let themes: [Theme<String>] = [
        .init(name: "Electronics", contentList: ["đģ", "đĨī¸", "âī¸", "đž", "đĨ", "đšī¸", "đŧ", "â¨ī¸", "đˇ", "đē", "đ", "đ ", "âī¸"], color: .init(name: "orange")),
        .init(name: "Animals", contentList: ["đļ", "đą", "đš", "đ¯", "đ­", "đ¸", "đŧ", "đģ"],contentLengthToShow: .number(7), color: .init(name: "green", isGradient: true)),
        .init(name: "People", contentList: ["đŽđŧââī¸", "đĩī¸", "đŠââī¸", "đˇââī¸", "đ", "đ¨âđž", "đ¨âđ¨", "đ¨âđ§", "đ§âđģ", "đ¨âđ­", "đ§âđŗ", "đ§âđĢ"], color:  .init(name: "red")),
        .init(name: "Flags", contentList: ["đŠđŋ", "đ§đĒ", "đ§đ¯", "đšđŠ", "đĢđŽ", "đŗđ´", "đĢđˇ", "đŦđˇ", "đēđ¸"], contentLengthToShow: .random, color: .init(name: "green", isGradient: true)),
        .init(name: "Vehicles", contentList: ["đ", "đ", "đŠī¸", "đ", "đī¸", "đ", "đ", "đ¸", "đ", "đŗī¸", "đ", "đ˛", "đ´"], color:  .init(name: "pink", isGradient: true)),
        .init(name: "Food", contentList: ["đ", "đĨ", "đ", "đ", "đ", "đĨŦ", "đ", "đ", "đĨ", "đĨ"], contentLengthToShow: .number(20),color:  .init(name: "yellow"))
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
