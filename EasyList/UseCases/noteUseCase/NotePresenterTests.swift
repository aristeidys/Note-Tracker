@testable import EasyList
import XCTest

class NotePresenterTests: XCTestCase {
    
    let sut = NotePresenter()
    
    func test_presents_placeholderText() {
        
        XCTAssertEqual(sut.placeholderText, sut.getFieldPlaceholder())
    }
    
}
