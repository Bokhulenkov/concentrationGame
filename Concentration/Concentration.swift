//
//  Concentration.swift
//  Concentration
//
//  Created by Alexander Bokhulenkov on 19.07.2023.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    func chooseCard(at index: Int){
    }
    
    init(numberOfPairsOrCards: Int) {
        for _ in 1...numberOfPairsOrCards{
            let card = Card()
            cards += [card, card]
        }
//        TODO: Shuffle the cards
    }
}
