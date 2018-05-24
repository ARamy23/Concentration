//
//  ViewController.swift
//  Concentration
//
//  Created by Ahmed Ramy on 5/21/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

/*
 This is the me7rm,
 me7rm's responsiblities are
 1- update UI in
    1- reset
    2- observe variables in the model
 */

import UIKit

class ViewController: UIViewController
{

    
    var game: Concentration!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var stopwatchLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    var observation: NSKeyValueObservation?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startGame()
    }
    
    fileprivate func updateFlipsCountLabel()
    {
        flipCountLabel.text = "_FLIPS: \(game.flipsCount)"
    }
    
    fileprivate func updateScoreLabel()
    {
        scoreLabel.text = "_SCORE: \(game.score)"
    }
    
    fileprivate func observeTimeCounter()
    {
        observation = game.counterObject.observe(\.counter, options: [.old,.new], changeHandler: { (object, change) in
            self.stopwatchLabel.text = String(format: "%.1f", object.counter)
        })
    }
    
    fileprivate func updateUI()
    {
        updateCardsFlipState()
        updateFlipsCountLabel()
        updateScoreLabel()
    }
    
    fileprivate func runChecks()
    {
        //is Cards Number Even
        if cardButtons.count % 2 != 0
        {
            fatalError("cards cannot be of an Odd value!")
        }
    }
    
    func startGame()
    {
        runChecks()
        game = Concentration(numberOfPairs: (cardButtons.count / 2))
        observeTimeCounter()
    }

    @IBAction func touchCard(_ sender: UIButton)
    {
        if let cardNumber = cardButtons.index(of: sender)
        {
            flipCard(at: cardNumber)
        } else
        {
            fatalError("Chosen Card was not in the cardButtons!*Check your outlets!*")
        }
    }
    
    fileprivate func updateCardsFlipState() {
        for index in cardButtons.indices
        {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFacedUp
            {
                button.setTitle(setEmoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 0)
            }
            else
            {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            }
        }
    }
    
    func flipCard(at cardNumber: Int)
    {
        //setup model
        game.chooseCard(at: cardNumber)
        updateUI()
        if game.flipsCount >= cardButtons.count, game.isAllCardsMatched()
        {
            let alert = UIAlertController(title: "Well Done!", message: "Wanna restart?", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
                self.game.reinitGame(numberOfPairs: self.cardButtons.count/2)
                self.resetCards()
            }))
            
            self.present(alert, animated: true)
        }
    }
    
    var emojiChoices = ["⏁", "⏄", "⏇", "⏉", "⏂", "⏅", "⏈", "⏊", "⏆"]
    var emoji = [Int: String]()
    
    func setEmoji(for card: Card) -> String
    {
        if emoji[card.identifier] == nil, emojiChoices.count > 0
        {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count - 1)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex) //this removes the emoji and returns it
        }
        return emoji[card.identifier] ?? "?"
    }
    
    fileprivate func resetCards()
    {
        for button in cardButtons
        {
            button.setTitle("", for: .normal)
            button.backgroundColor =  #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        }
    }
    
    @IBAction func didTapResetButton(_ sender: Any)
    {
        game.reinitGame(numberOfPairs: cardButtons.count / 2)
        resetCards()
    }
    
}

class Observers: NSObject
{
    
}

