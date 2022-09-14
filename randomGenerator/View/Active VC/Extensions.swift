//
//  Extensions.swift
//  randomGenerator
//
//  Created by R C on 9/22/21.
//

import UIKit
extension UIButton {
    func createProfileButton() {
        layer.cornerRadius = 20.0
        backgroundColor = UIColor.separator
        layer.borderWidth = 7.0
        layer.borderColor =  UIColor.black.cgColor
        layer.backgroundColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.10
//        setTitleColor(.white, for: .normal)
//        setTitleColor(.blue, for: .highlighted)
        layer.shadowRadius = 5
        translatesAutoresizingMaskIntoConstraints = false
        layer.shadowOffset = CGSize(width: 0, height: 10)
        
    }
}
