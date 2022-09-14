////
////  ColorsViewController.swift
////  randomGenerator
////
////  Created by R C on 11/29/20.
////
//
//import UIKit
//
//class ColorsViewController: UIViewController {
//    
//    @IBOutlet weak var randomColorLabel: UILabel!
//    @IBOutlet weak var colorHistory: UILabel!
//    @IBOutlet weak var emptyColorArray: UIButton!
//    @IBOutlet weak var generateRandomColor: UIButton!
//    
//    var colors: [UIColor] = [UIColor.red, UIColor.blue, UIColor.yellow, UIColor.black, UIColor.white, UIColor.green, UIColor.cyan, UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red]
//    var colorArray: [String] = []
//    
//    let background = [#colorLiteral(red: 1, green: 0.7320935764, blue: 0.7135747429, alpha: 1),#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1),#colorLiteral(red: 0.1528412254, green: 0.7525253203, blue: 1, alpha: 1),#colorLiteral(red: 0.0842237249, green: 0.9515381455, blue: 0.6593266129, alpha: 1),#colorLiteral(red: 0.7632441719, green: 0.8320771161, blue: 1, alpha: 1),#colorLiteral(red: 0.6001875981, green: 0.4289812889, blue: 1, alpha: 1),#colorLiteral(red: 0.7343033071, green: 1, blue: 0.7817267995, alpha: 1),#colorLiteral(red: 1, green: 0.9323324378, blue: 0.6373470138, alpha: 1),#colorLiteral(red: 0.5294112564, green: 0.8574282353, blue: 1, alpha: 1),#colorLiteral(red: 0.5907132616, green: 0.6255102752, blue: 1, alpha: 1)]
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        colorHistory.isHidden = true
//        generateRandomColor.layer.cornerRadius = 25
//        
//        
//    }
//    @IBAction func generateColor(_ sender: UIButton) {
//      //  self.view.backgroundColor = colors.randomElement()
//        
//        
//        colorArray.append(randomColorLabel.text!)
//        colorHistory.isHidden = false
//        colorHistory.text = colorArray.randomElement()
////        randomColorLabel.text = String(colors.randomElement())
//        colorCheck()
//    }
//    
//    @IBAction func emptyColorArray(_ sender: UIButton) {
//        colorArray.removeAll()
//        colorHistory.text = colorArray.joined(separator: ", ")
//    }
//
//    
//    
//    func colorCheck() {
//        
//          //  print("yeh yeah")
//        }
//    }
//
//
//
//
////
////func hexStringToUIColor (hex:String) -> UIColor {
////    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
////
////    if (cString.hasPrefix("#")) {
////        cString.remove(at: cString.startIndex)
////    }
////
////    if ((cString.count) != 6) {
////        return UIColor.gray
////    }
////
////    var rgbValue:UInt64 = 0
////    Scanner(string: cString).scanHexInt64(&rgbValue)
////
////    return UIColor(
////        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
////        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
////        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
////        alpha: CGFloat(1.0)
////    )
////}
