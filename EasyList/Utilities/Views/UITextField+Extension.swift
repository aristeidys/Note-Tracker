//
//  CustomTextField.swift
//  EasyList
//
//  Created by Aristeidis Panagiotopoulos on 30/10/2018.
//  Copyright © 2018 arisPanagiotopoulos. All rights reserved.
//

import UIKit

extension UITextField {
    
    func showInvalid() {
        guard onlyOneUnderlineExists() == false else {
            return
        }
        let lineView = UIView()
        lineView.accessibilityIdentifier = "underline"
        lineView.backgroundColor = .red
        lineView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lineView)
        
        let metrics = ["width" : NSNumber(value: 1)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
    }
    
    func showValid() {
        for view in self.subviews {
            if view.accessibilityIdentifier == "underline" {
                view.removeFromSuperview()
            }
        }
    }
    
    func onlyOneUnderlineExists() -> Bool {
        var count = 0
        
        for view in self.subviews {
            if view.accessibilityIdentifier == "underline" {
                count = count + 1
            }
        }
        return count == 1 ? true : false
    }}
