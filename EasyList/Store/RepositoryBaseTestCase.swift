//
//  RepositoryBaseTestCase.swift
//  EasyListTests
//
//  Created by Aristeidis Panagiotopoulos on 25/10/2018.
//  Copyright © 2018 arisPanagiotopoulos. All rights reserved.
//

import XCTest
import RealmSwift

class RepositoryBaseTestCase: XCTestCase {

    var realm = try! Realm()
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func deleteAllData() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
