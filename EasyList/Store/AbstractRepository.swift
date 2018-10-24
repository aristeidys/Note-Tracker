//
//  AbstractRepository.swift
//  EasyList
//
//  Created by Aristeidis Panagiotopoulos on 23/10/2018.
//  Copyright © 2018 arisPanagiotopoulos. All rights reserved.
//

import Foundation
import RealmSwift

protocol Repository {
    
}

public class AbstractRepository: Repository {
    
    let realm = try! Realm()
    
}
