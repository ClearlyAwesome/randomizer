////
////  ExercisesViewController.swift
////  randomGenerator
////
////  Created by R C on 11/30/20.
////
//
//import UIKit
//
//class ExercisesViewController: UIViewController {
//    
//    @IBOutlet weak var randomExerciseLabel: UILabel!
//    @IBOutlet weak var generateRandomExercise: UIButton!
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        generateRandomExercise.layer.cornerRadius = 25.0
//        
//        
//    }
//    
//    var listOfExercise: [String] = ["Back extension", "Bench press", "Bent-over row", "Biceps curl", "Burpees", "Cherry Pickers", "Chest fly", "Crunches", "Deadlift", "Flutter kicks", "Hip Abductor", "Jumping rope", "Knee ups", "Lateral raise", "Leg curl", "Leg extension", "Leg press", "Leg raise", "Lunges", "Pull-down", "Pull-up", "Push-up", "Pushdown", "Russian twist", "Seated calf raise", "Shoulder fly", "Shoulder press", "Shoulder shrug", "Side Crunches", "Sit-ups", "Sprints", "Squats", "Standing calf raise", "Standing Crunches", "Suicides", "Swimming", "Triceps extensions", "Upright row", "Jumping Jacks", "Plank", "Hip raises", "High knees", "Side plank"]
//    
//    @IBAction func generateExercise(_ sender: UIButton) {
//        
//        randomExerciseLabel.text = listOfExercise.randomElement()
//        
//    }
//    
//   
//
//}
