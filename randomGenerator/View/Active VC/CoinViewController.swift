//
//  CoinViewController.swift
//  randomGenerator
//
//  Created by R C on 11/30/20.
//

import UIKit

class CoinViewController: UIViewController {
    
    
    
    @IBOutlet weak var coinButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var generateCoinToss: UIButton!
    @IBOutlet weak var headsCounter: UILabel!
    @IBOutlet weak var tailsCounter: UILabel!
    
    
    var numberOfHeads = 0
    var numberOfTails = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateCoinToss.layer.cornerRadius = 25
        generateCoinToss.sizeToFit()
        let alert = UIAlertController(title: "Welcome!", message: "Flip coin or press button", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func coinButtonAction(_ sender: UIButton) {
        statusLabel.text = " "
        
        //flip the coin on click. --True = heads, false=tails
        let status = Bool.random()
        doAnimationCoin(coinButton)
        generateCoinToss.isEnabled = false
        coinButton.isEnabled = false
        if status {
            //true =heads
            
            //set button image
            coinButton.setImage(UIImage(named: "us-quarter-front"), for: .normal)
            self.numberOfHeads += 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                //set label text
                self.statusLabel.text = "Heads"
                self.headsCounter.text = String(self.numberOfHeads)
            }
        } else {
            //false = tails
            numberOfTails += 1
            //set button image
            coinButton.setImage(UIImage(named: "us-quarter-back"), for: .normal)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                //set label text
                self.statusLabel.text = "Tails"
                self.tailsCounter.text = String(self.numberOfTails)
                self.generateCoinToss.isEnabled = true
                self.coinButton.isEnabled = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
            self.generateCoinToss.isEnabled = true
            self.coinButton.isEnabled = true
        }
    }
    //advanced coin animation
    func doAnimationCoin(_ button: UIButton) {
        let coinFlip = CATransition()
        coinFlip.startProgress = 0.0
        coinFlip.endProgress = 2.0
        coinFlip.type = CATransitionType(rawValue: "flip")
        coinFlip.subtype = CATransitionSubtype(rawValue: "fromBottom")
        coinFlip.duration = 0.3
        coinFlip.repeatCount = 7
        button.layer.add(coinFlip, forKey: "transition")
        
    }
}
