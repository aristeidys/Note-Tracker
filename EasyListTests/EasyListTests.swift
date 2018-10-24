//
//  EasyListTests.swift
//  EasyListTests
//
//  Created by Aristeidis Panagiotopoulos on 23/10/2018.
//  Copyright © 2018 arisPanagiotopoulos. All rights reserved.
//

import XCTest
@testable import EasyList
import RealmSwift
import Realm

class EasyListTests: XCTestCase {

    let realm = AbstractRepository().realm
    
    func testPrintRealmFilePath() {
        guard let url = realm.configuration.fileURL?.absoluteString else {
            
            XCTFail()
            return
        }
        print("🎆\(url)🎆")
    }
}
