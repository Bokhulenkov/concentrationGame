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
    
    private var themeEmoji = [
        "Fruits": ("🍏🍊🍓🍉🍇🍒🍌🥝🍆🍑🍋", #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)),
        "Activity": ("⚽️🏄‍♂️🏑🏓🚴‍♂️🥋🎸🎯🎮🎹🎲", #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)),
        "Animals": ("🐶🐭🦊🦋🐢🐸🐵🐞🐿🐇🐯", #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)),
        "Christmas": ("🎅🎉🦌⛪️🌟❄️⛄️🎄🎁🔔🕯", #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)),
        "Clothes": ("👚👕👖👔👗👓👠🎩👟⛱🎽👘", #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)),
        "Halloween": ("💀👻👽🙀🦇🕷🕸🎃🎭😈⚰", #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1), #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)),
        "Transport": ("🚗🚓🚚🏍✈️🚜🚎🚲🚂🛴", #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
    ]

private lazy var emojiChoices = " "
private var emoji = [Card: String]()
private var backgroundColor = UIColor.black
private var cardBackColor = UIColor.orange
    
    var attributedString = NSAttributedString()
    
    typealias Theme = (emojiChoices: String, backgroundColor: UIColor, cardBackColor: UIColor)
    
    private var indexTheme = 0 {
        didSet {
            print(indexTheme, keys[indexTheme])
            titleLabel.text = "\(keys[indexTheme])"
            (emojiChoices, backgroundColor, cardBackColor) = themeEmoji[keys[indexTheme]] ?? ("?", .black, .orange)
            emoji = [Card: String]()
            updateAppearance()
        }
    }
    
    private var keys: [String] {
        Array(themeEmoji.keys)
    }

    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBAction private func newGame(_ sender: UIButton) {
        game.newGame()
        indexTheme = keys.count.arc4random
        updateViewFromModel()
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet{
            let attributes: [NSAttributedString.Key: Any] = [
                .strokeWidth: 5,
                .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            ]
            attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        }
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender)  {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
        indexTheme = keys.count.arc4random
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
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 0) : cardBackColor
                button.setTitle(" ", for: .normal)
            }
            scoreLabel.text = "Score: \(game.scoreCount)"
//            flipCountLabel.text = "Flips: \(game.flipCount)"
            flipCountLabel.attributedText = attributedString
        }
    }
    
   private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    private func updateAppearance() {
        view.backgroundColor = backgroundColor
        flipCountLabel.textColor = cardBackColor
        scoreLabel.textColor = cardBackColor
        titleLabel.textColor = cardBackColor
        newGameButton.setTitleColor(backgroundColor, for: .normal)
        newGameButton.backgroundColor = cardBackColor
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
