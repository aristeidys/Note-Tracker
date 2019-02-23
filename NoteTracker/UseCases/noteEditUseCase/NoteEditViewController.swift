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
    
    let worker = NoteWorker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let note = note {
            noteTitle.text = note.title
            noteDescription.text = note.text
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        try! Realm().write {
            note?.title = noteTitle.text ?? ""
            note?.text = noteDescription.text
        }
    }
}
