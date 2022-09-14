//
//  LetterViewController.swift
//  randomGenerator
//
//  Created by R C on 11/29/20.
//

import UIKit

class LetterViewController: UIViewController {
    
    @IBOutlet weak var randomLetterLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var letterHistory: UILabel!
    @IBOutlet weak var emptyLetterArray: UIButton!
    @IBOutlet weak var generateRandomLetter: UIButton!
    
    
    var alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    var historyOfLetters: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateRandomLetter.layer.cornerRadius = 25.0
        letterHistory.isHidden = true
        
    }
    
    @IBAction func generateLetter(_ sender: UIButton) {
        randomLetterLabel.text = alphabet.randomElement()!
        historyOfLetters.append(randomLetterLabel.text!)
        letterHistory.isHidden = false
        letterHistory.text = historyOfLetters.joined(separator: ", ")
        
    }
    
    @IBAction func emptyLetters(_ sender: UIButton) {
        historyOfLetters.removeAll()
        letterHistory.isHidden = true
        letterHistory.text = historyOfLetters.joined(separator: ", ")
    }
    
    
    
    
    
}
