//
//  KeyboardViewController.swift
//  EasyList
//
//  Created by Aristeidis Panagiotopoulos on 29/10/2018.
//  Copyright © 2018 arisPanagiotopoulos. All rights reserved.
//

import UIKit

class KeyboardViewController: UIViewController {
    
    internal var bottomViewConstraint: NSLayoutConstraint?
    internal var viewToMove: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        self.bottomViewConstraint?.constant = 0

        UIView.animate(withDuration: 0) {
            self.viewToMove?.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        self.bottomViewConstraint?.constant = -keyboardRect.height

        UIView.animate(withDuration: 0) {
            self.viewToMove?.layoutIfNeeded()
        }
        
        
    }
}
