//
//  ViewController.swift
//  Concentration
//
//  Created by Alexander Bokhulenkov on 17.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOrCards: numberOfPairsCards)
    
    var numberOfPairsCards: Int {
            return (cardButtons.count + 1) / 2
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
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.setTitle(emoji(for: card), for: .normal)
            } else {
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                button.setTitle(" ", for: .normal)
            }
            scoreLabel.text = "Score: \(game.scoreCount)"
            flipCountLabel.text = "Flips: \(game.flipCount)"
        }
    }
    
   private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
    
        private var themeEmoji = [
            "Fruits": ["🍏", "🍊", "🍓", "🍉", "🍇", "🍒", "🍌", "🥝", "🍆", "🍑", "🍋"],
            "Activity": ["⚽️", "🏄‍♂️", "🏑", "🏓", "🚴‍♂️","🥋", "🎸", "🎯", "🎮", "🎹", "🎲"],
            "Animals": ["🐶", "🐭", "🦊", "🦋", "🐢", "🐸", "🐵", "🐞", "🐿", "🐇", "🐯"],
            "Christmas": ["🎅", "🎉", "🦌", "⛪️", "🌟", "❄️", "⛄️","🎄", "🎁", "🔔", "🕯"],
            "Clothes": ["👚", "👕", "👖", "👔", "👗", "👓", "👠", "🎩", "👟", "⛱","🎽", "👘"],
            "Halloween": ["💀", "👻", "👽", "🙀", "🦇", "🕷", "🕸", "🎃", "🎭","😈", "⚰"],
            "Transport": ["🚗", "🚓", "🚚", "🏍", "✈️", "🚜", "🚎", "🚲", "🚂", "🛴"]
        ]
    
    private lazy var emojiChoices = themeEmoji.randomElement()?.value ?? ["?"]
    private var emoji = [Int: String]()
    
    private var indexTheme = 0 {
        didSet {
            print(indexTheme, keys[indexTheme])
            titleLabel.text = "\(keys[indexTheme])"
            emojiChoices = themeEmoji[keys [indexTheme]] ?? ["?"]
            emoji = [Int: String]()
        }
    }
    
    private var keys:[String] {
        Array(themeEmoji.keys)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
        indexTheme = keys.count.arc4random
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBAction private func newGame(_ sender: UIButton) {
        game.newGame()
        indexTheme = keys.count.arc4random
        updateViewFromModel()
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender)  {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
