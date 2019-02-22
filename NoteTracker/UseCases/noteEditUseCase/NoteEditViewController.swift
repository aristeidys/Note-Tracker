//
//  NoteEditViewController.swift
//  Note Tracker
//
//  Created by Aristeidis Panagiotopoulos on 21/02/2019.
//  Copyright © 2019 arisPanagiotopoulos. All rights reserved.
//

import UIKit

class NoteEditViewController: UIViewController {
    
    var note: NoteModel?
    
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteDescription: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let note = note {
            noteTitle.text = note.title
            noteDescription.text = note.text
        }
    }
}
