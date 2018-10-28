//
//  NoteModels.swift
//  EasyList
//
//  Created by Aristeidis Panagiotopoulos on 23/10/2018.
//  Copyright (c) 2018 arisPanagiotopoulos. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import RealmSwift

@objcMembers class NoteModel: Object {
    
    dynamic var id = 0
    dynamic var title: String = ""
    dynamic var text: String = ""
    dynamic var editedDate: Date? = nil
    
    convenience init(title: String = "", text: String = "") {
        self.init()
        self.title = title
        self.text = text
    }
}

enum Note
{
  // MARK: Use cases
  
  enum Create
  {
    struct Request
    {
        var title: String
        var text: String
    }
    struct Response
    {
    }
    struct ViewModel
    {
    }
  }
}
