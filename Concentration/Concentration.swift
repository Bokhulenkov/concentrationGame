//
//  Concentration.swift
//  Concentration
//
//  Created by Alexander Bokhulenkov on 19.07.2023.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    private(set) var scoreCount = 0
    var seenCards = Set<Int>()
    private(set) var flipCount = 0
    
    init(numberOfPairsOrCards: Int) {
        assert(numberOfPairsOrCards > 0, "Concentration.init (\(numberOfPairsOrCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOrCards{
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    mutating func chooseCard(at index: Int){
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
//                check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    scoreCount += 2
                } else {
//                Penalty score labal
                    if seenCards.contains(index){
                        scoreCount -= 1
                    }
                    if seenCards.contains(matchIndex){
                        scoreCount -= 1
                    }
                    seenCards.insert(index)
                    seenCards.insert(matchIndex)
                }
                cards[index].isFaceUp = true
            } else {
//                no cards or 2 cards are faceUp
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    mutating func newGame(){
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
         flipCount = 0
         cards.shuffle()
    }
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
