@testable import EasyList
import XCTest


class NoteCellViewTests: XCTestCase {
    
    let model = NoteModel(title: "title", text: "description")
    let vc = UIViewController()
    let sut = NoteCellView()
    
    func test_view_isCompleted() {
        
        vc.view.addSubview(sut)
        
        _ = vc.view
        
        model.editedDate = Date()
        
        //sut.setupView(model)
        
       // XCTAssertEqual(sut.titleLabel.text, "title")
       // XCTAssertEqual(sut.descriptionLabel.text, "description")
       // XCTAssertNotNil(sut.dateLabel.text)
    }
}
