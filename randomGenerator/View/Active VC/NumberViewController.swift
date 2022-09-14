//
//  ViewController.swift
//  randomGenerator
//
//  Created by R C on 10/28/20.
//

import UIKit

class NumberViewController: UIViewController {
    //MARK: - UI Interface
    @IBOutlet weak var randomNumberLabel: UILabel!
    @IBOutlet weak var minimumTextField: UITextField!
    @IBOutlet weak var maximumTextField: UITextField!
    @IBOutlet weak var generateRandom: UIButton!
    @IBOutlet weak var history: UILabel!
    @IBOutlet weak var emptyNumberArray: UIButton!
    @IBOutlet weak var historyLabel: UILabel!
    
    //MARK: - Common Variables
    var minNumber: Int = 1
    var maxNumber: Int = 100
    var randomNumber: Int = 1
    var randomHistory: [String] = []
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //Marking things as a delegate allows me to call upon them when i need to change or update them from the viewController
        overrideUserInterfaceStyle = .dark
        minimumTextField.delegate = self
        maximumTextField.delegate = self
        history.isHidden = true
        emptyNumberArray.isHidden = true
        
        //This is making my button "pretty"
        generateRandom.layer.cornerRadius = 25.0
        
        //I've added starting numbers for the user. This way, they can easily press UIButton and generate a random number.
        minimumTextField.text = String(0)
        maximumTextField.text = String(99)
        
        //This allows a user to tap away from the keyboard and exit the keyboard. It uses the standard APPLE function, 'shouldEndEditing'
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - Button Functionality
    @IBAction func randomNumber(_ sender: UIButton) {
        //General coding statements to say that editing has ended for those fields.
        minimumTextField.endEditing(true)
        maximumTextField.endEditing(true)
        //Just making sure that text is inputted into the field before submitting.
        guard minimumTextField.text != nil else { return }
        guard maximumTextField.text != nil else { return }
        
        if minimumTextField.text!.count >= 10 || maximumTextField.text!.count >= 10  {
            let alert = UIAlertController(title: "Error:", message: "Please choose a number between 0...999,999,999", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            eliminateErrors()
        }
    }
    
    @IBAction func emptyNumbers(_ sender: UIButton) {
        randomHistory.removeAll()
        history.text = randomHistory.joined(separator: ", ")
        history.isHidden = true
        emptyNumberArray.isHidden = true
        
    }
    //MARK: - Eliminate any Errors
    func eliminateErrors() {
        //This if-let statement converts my string into an integer and sets the min and max numbers to that converted string.
        if let myMinNumber = NumberFormatter().number(from: minimumTextField.text!), let myMaxNumber = NumberFormatter().number(from: maximumTextField.text!)   {
            minNumber = myMinNumber.intValue
            maxNumber = myMaxNumber.intValue
            //this is the function from below. basically my magic solution for all the errors i was receiving.
            randomNumberGenerator(minNumber, _to: maxNumber)
            historyLabel.isHidden = false
        } else {
            //Me just being funny.
            randomNumberLabel.text = ("ruh roh")
        }
    }
    func randomNumberGenerator (_ from: Int, _to: Int) {
        //Generates a random number
        var randomNumber = arc4random_uniform(UInt32(abs((maxNumber - minNumber))))
        //Checks to see if the random number is within range of min and max numbers and adjusts it if it isn't.
        if randomNumber < minNumber || randomNumber > maxNumber {
            randomNumber = (UInt32(minNumber + 1)) + arc4random_uniform(UInt32(abs((maxNumber - minNumber))))
            randomNumberLabel.text = minimumTextField.text
        }
        //An additional IF-ELSE statement that changes the max number if someone types in something wrong and actually makes the min number BIGGER than the max number.
        if maxNumber < minNumber {
            maxNumber = minNumber + 1
            maximumTextField.text = String(minNumber + 1)
            randomNumberLabel.text = minimumTextField.text
        } else {
            randomNumberLabel.text = String(randomNumber)
            randomHistory.append(String(Int(randomNumber)))
        }
        history.isHidden = false
        emptyNumberArray.isHidden = false
        
        history.text = randomHistory.joined(separator: ", ")
    }
}
//MARK: - UITextFieldDelegate
extension NumberViewController: UITextFieldDelegate {
    //This will work for a standard keyboard. This basically says, if ENTER/RETURN is pressed...exit keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        minimumTextField.endEditing(true)
        maximumTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if minimumTextField.hasText == true && maximumTextField.hasText == true {
            minimumTextField.endEditing(true)
            maximumTextField.endEditing(true)
        }
        return true
    }
    
    //This is a pretty pointless func right now. 
    func textFieldDidEndEditing(_ textField: UITextField) {
        if minimumTextField.text!.count >= 10 || maximumTextField.text!.count >= 10 {
            minimumTextField.endEditing(true)
            maximumTextField.endEditing(true)
        }
    }
    
}
