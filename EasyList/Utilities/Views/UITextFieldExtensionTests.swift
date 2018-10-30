@testable import EasyList
import XCTest

class UITextFieldExtensionTests: XCTestCase {
    
    let sut = UITextField()
    
    func test_add_remove_validityLine_for_textField() {
        sut.showInvalid()
        XCTAssert(onlyOneUIViewExists())
        sut.showInvalid()
        XCTAssert(onlyOneUIViewExists())
        
        sut.showValid()
        XCTAssertFalse(onlyOneUIViewExists())
        sut.showValid()
        XCTAssertFalse(onlyOneUIViewExists())

    }
    
    func onlyOneUIViewExists() -> Bool {
        
        var count = 0
        for view in sut.subviews {
            if view.accessibilityIdentifier == "underline" {
                count = count + 1
            }
        }
        return count == 1 ? true : false
    }
}
