//
//  Popups.swift
//  NoteTracker
//
//  Created by Aristeidis Panagiotopoulos on 19/02/2019.
//  Copyright © 2019 arisPanagiotopoulos. All rights reserved.
//

import UIKit

class Popups {
    static func presentDeletePopup(onvc: UIViewController, with callback: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController.init(title: "Are you sure?", message: "This action cannot be undone.", preferredStyle: .actionSheet)
        let continueAction = UIAlertAction.init(title: "Continue", style: .destructive, handler: callback )
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: {(action) in } )
        alert.addAction(continueAction)
        alert.addAction(cancelAction)
        
        onvc.present(alert, animated: true, completion: nil)
    }
}
