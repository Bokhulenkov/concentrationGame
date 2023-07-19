//
//  ViewController.swift
//  Concentration
//
//  Created by Alexander Bokhulenkov on 17.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton){
        if button.currentTitle == emoji {
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            button.setTitle(" ", for: .normal)
        } else {
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            button.setTitle(emoji, for: .normal)
        }
    }
    
    var emojiChoices = ["👻", "🎃", "☠️", "👽"]
 
    
//    UI

    
    
    
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender)  {
            flipCard(withEmoji: emojiChoices[cardNumber] , on: sender)
        }
    }
    
    
    
    
}
