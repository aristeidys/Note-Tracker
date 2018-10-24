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

class NoteModel: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var text: String = ""
    @objc dynamic var editedDate: Date? = nil
}

enum Note
{
  // MARK: Use cases
  
  enum Something
  {
    struct Request
    {
    }
    struct Response
    {
    }
    struct ViewModel
    {
    }
  }
}
