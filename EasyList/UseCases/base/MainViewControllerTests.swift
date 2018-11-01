import XCTest
@testable import EasyList

class MainViewControllerTests: XCTestCase {
    
    let sut: MainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
    
    func test_viewDidLoad_sets_viewToMove() {
        
        let constraint = NSLayoutConstraint()
        let view = UIView()
        sut.bottomConstraint = constraint
        sut.textFieldView = view
        
        _ = sut.view
        XCTAssertNotNil(sut.bottomConstraint)
        XCTAssertNotNil(sut.noteTableView)
        XCTAssertNotNil(sut.textFieldView)
    }
}
