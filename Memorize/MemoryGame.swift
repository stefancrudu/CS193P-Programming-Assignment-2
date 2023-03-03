//
//  GameMemorize.swift
//  Memorize
//
//  Created by Stefan Crudu on 02.03.2023.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: [Card]
    var score: Int = 0
    var indexCardFlipped: Int? = nil
    
    init(numberOfCards: Int, contentCard: (Int) -> CardContent) {
        cards = [Card]()
        
        for index in 0..<numberOfCards {
            cards.append(Card(content: contentCard(index), id: index * 2))
            cards.append(Card(content: contentCard(index), id: index * 2 + 1))
        }
        
        cards = cards.shuffled()
    }
    
    mutating func chooseCard(_ card: MemoryGame<CardContent>.Card) {
        guard let index = cards.firstIndex(where: {$0.id == card.id}),
            !cards[index].isFaceUp,
            !cards[index].isMatch else { return }

        updateScore(chooseCardIndex: index)
        updateCardListProperties(chooseCardIndex: index)
        cards[index].timeWhenLastCardWasChosen = Date.now
        indexCardFlipped = indexCardFlipped == nil ? index : nil
    }
    
    struct Card: Identifiable{
        var isFaceUp: Bool = false
        var isMatch: Bool = false
        var isAlreadySeen: Bool = false
        var timeWhenLastCardWasChosen: Date?
        let content: CardContent
        let id: Int
    }
}

//MARK: - Private
private extension MemoryGame {
    mutating func updateCardListProperties(chooseCardIndex index: Int) {
        if let indexOfCardFlipped = indexCardFlipped {
            if cards[indexOfCardFlipped].content == cards[index].content {
                cards[index].isMatch.toggle()
                cards[indexOfCardFlipped].isMatch.toggle()
            }
        } else {
            for index in cards.indices {
                cards[index].isFaceUp = false
            }
        }
        cards[index].isAlreadySeen = true
        cards[index].isFaceUp = true
    }
    
    mutating func updateScore(chooseCardIndex index: Int) {
        guard let indexCardFlipped = indexCardFlipped else { return }

        if cards[indexCardFlipped].content == cards[index].content {
            score += max(10 - getSecondsBetweenLastChoose(cards[index].timeWhenLastCardWasChosen), 1)
        } else {
            score -= cards[index].isAlreadySeen ? 1 : 0
            score -= cards[indexCardFlipped].isAlreadySeen ? 1 : 0
        }
    }
    
    private func getSecondsBetweenLastChoose(_ lastTime: Date?) -> Int{
        return Int(Date.now.timeIntervalSinceReferenceDate - (lastTime?.timeIntervalSinceReferenceDate ?? Date.now.timeIntervalSinceReferenceDate))
    }
}
