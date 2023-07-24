//
//  Concentration.swift
//  Concentration
//
//  Created by Alexander Bokhulenkov on 19.07.2023.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var scoreCount = 0
    var seenCards = Set<Int>()
    
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
//                check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
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
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
//                no cards or 2 cards are faceUp
                for flipdownIndex in cards.indices {
                    cards[flipdownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
     func newGame(){
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
         cards.shuffle()
    }
    
    
    
    init(numberOfPairsOrCards: Int) {
        for _ in 1...numberOfPairsOrCards{
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
