//
//  EightBallViewController.swift
//  randomGenerator
//
//  Created by R C on 11/29/20.
//

import UIKit

class EightBallViewController: UIViewController {
    
    @IBOutlet weak var triangleButton: UIButton!
    @IBOutlet weak var generateFate: UIButton!
    
    var choices: [String] = ["Yes!", "No!", "Your guess is as good as mine!","You actually know the answer to this.", "Doesn't look good.", "I'd say 'Go for it!'", "Heck No!", "Ummm...", "Give me some time to think.", "I'm not qualified to answer.", "Be back in 10 minutes.", "You know it!", "Yup!", "F**K NO!", "I wouldn't", "What are you waiting on?!", "Sounds like a great idea to me.", "I'm just a magic ball...err app. IDK."]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateFate.layer.cornerRadius = 25
        let alert = UIAlertController(title: "Welcome!", message: "Shake 8-ball or press button", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        triangleButton.titleLabel?.textAlignment = .center
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        triangleButton.isHidden = true
        generateFate.isEnabled = false
        triangleButton.setTitle(" ", for: .normal)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.triangleButton.isHidden = false
            self.triangleButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            self.triangleButton.titleLabel?.textAlignment = .center
            self.triangleButton.setTitle(self.choices.randomElement(), for: .normal)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.generateFate.isEnabled = true
            }
            
        }
    }
    
    @IBAction func chooseYourFate(_ sender: UIButton) {
        triangleButton.isHidden = true
        generateFate.isEnabled = false
        triangleButton.setTitle(" ", for: .normal)
        triangleButton.titleLabel?.textAlignment = .center
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.triangleButton.isHidden = false
            self.triangleButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            self.triangleButton.setTitle(self.choices.randomElement(), for: .normal)
            self.triangleButton.titleLabel?.textAlignment = .center
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.generateFate.isEnabled = true
        }
    }
}
