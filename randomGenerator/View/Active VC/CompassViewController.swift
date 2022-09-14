//
//  CompassViewController.swift
//  randomGenerator
//
//  Created by R C on 11/29/20.
//

import UIKit

class CompassViewController: UIViewController {
    
    @IBOutlet weak var randomCompassLabel: UILabel!
    @IBOutlet weak var compassHistory: UILabel!
    @IBOutlet weak var clearCompassHistory: UIButton!
    @IBOutlet weak var generateCompassDirection: UIButton!
    @IBOutlet weak var compassHistoryLabel: UILabel!
    
    var compass:[String] = ["North", "West", "East", "South", "Northwest", "Northeast", "Southwest", "Southeast", "South-Southeast", "South-Southwest", "North-Northwest", "North-Northeast"]
    var historyOfDirections: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateCompassDirection.layer.cornerRadius = 25
        compassHistory.isHidden = true
        clearCompassHistory.isHidden = true
        compassHistoryLabel.isHidden = true
        
        
    }
    
    @IBAction func generateDirection(_ sender: UIButton) {
        randomCompassLabel.text = compass.randomElement()
        historyOfDirections.append(randomCompassLabel.text!)
       // compassHistory.isHidden = false
      //  compassHistory.text = historyOfDirections.joined(separator: ", ")
    }
    
//    @IBAction func clearCompassDirections(_ sender: UIButton) {
//        historyOfDirections.removeAll()
//        compassHistory.text = historyOfDirections.joined(separator: ", ")
//        compassHistory.isHidden = true
//    }
}
