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
    
    func test_shouldReloadTable_called() {
        // setup
        let helper = NoteCreateViewController()
        let sut = ReloadTableDelegateSpy()
        helper.reloadDelegate = sut
        
        // when
        helper.onNoteSubmitted("Any")
        
        // then
        assert(sut.shouldReloadCalled)
    }
    
    
    func test_should_have_embedded_viewControllers() {
        
        _ = sut.view
        
        let helper = sut.children.filter{$0 is NoteTableViewController}.first as? NoteTableViewController

        
        XCTAssertEqual(sut.tableViewController as? NoteTableViewController, helper)
    }
    
    func test_ShouldCall_ShouldReaload() {
        
        let helper: ReloadTableDelegateSpy = ReloadTableDelegateSpy()
        
        sut.tableViewController = helper
        
        sut.shouldReloadTable()
        
        assert(helper.shouldReloadCalled)
    }
    
    // MARK: Spies
    class ReloadTableDelegateSpy: ReloadTableDelegate {
        
        var shouldReloadCalled = false
        
        func shouldReloadTable() {
            shouldReloadCalled = true
        }
    }
}
