//
//  NoteModeTests.swift
//  EasyListTests
//
//  Created by Aristeidis Panagiotopoulos on 24/10/2018.
//  Copyright © 2018 arisPanagiotopoulos. All rights reserved.
//

@testable import EasyList
import XCTest

class NoteModeTests: XCTestCase {

    func testNoteModeInitiallization() {
        
        _ = NoteModel(title: "hello")
        _ = NoteModel(title: "dfds", text: "fdf")
        
    }

}
