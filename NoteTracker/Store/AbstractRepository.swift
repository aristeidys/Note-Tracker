//
//  AbstractRepository.swift
//  NoteTracker
//
//  Created by Aristeidis Panagiotopoulos on 23/10/2018.
//  Copyright © 2018 arisPanagiotopoulos. All rights reserved.
//

import Foundation
import RealmSwift

protocol Repository {
    func save(entity: Object)
}

public class AbstractRepository: Repository {
    
    let realm = try! Realm()
    
    internal func save(entity: Object) {
        
        try! realm.write {
            realm.add(entity)
        }
    }
    
    internal func delete(entity: Object?) {
        
        guard let existingEntity = entity else {
            return
        }
        
        try! realm.write {
            realm.delete(existingEntity)
        }
    }
    
    internal func delete(entities: [Object]?) {
        
        guard let existingEntity = entities else {
            return
        }
        
        try! realm.write {
            realm.delete(existingEntity)
        }
    }
}
