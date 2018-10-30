import XCTest
@testable import EasyList

class MainViewControllerTests: XCTestCase {
    
    
    func tests_viewDidLoad_sets_viewToMove() {
        
        let sut = MainViewController()
        let constraint = NSLayoutConstraint()
        let view = UIView()
        sut.bottomConstraint = constraint
        sut.textFieldView = view
        
        _ = sut.view
        XCTAssertNotNil(sut.bottomViewConstraint)
        XCTAssertNotNil(sut.viewToMove)

    }
}
