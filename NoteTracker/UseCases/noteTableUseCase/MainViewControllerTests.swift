import XCTest
@testable import NoteTracker

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
    
    func test_should_Have_Navigation_Bar_Title() {
        _ = sut.view
        
        assert(sut.title == "Note Tracker")
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
    
    func test_should_embed_createViewcontroller() {
        
        _ = sut.view
        
        let helper = sut.children.filter{$0 is NoteCreateViewController}.first as? NoteCreateViewController
        
        XCTAssertNotNil(helper?.reloadDelegate)
    }
    
    
    func test_should_embed_noteTableviewController() {
        
        _ = sut.view
        
        let helper = sut.children.filter{$0 is NoteTableViewController}.first as? NoteTableViewController

        
        XCTAssertEqual(sut.tableViewController as? NoteTableViewController, helper)
    }
    
    func test_ShouldCall_ShouldReaload() {
        
        let helper: ReloadTableDelegateSpy = ReloadTableDelegateSpy()
        
        sut.tableViewController = helper
        
        sut.reload()
        
        assert(helper.shouldReloadCalled)
    }
    
    func test_clickOn_Table_should_Close_keyboard() {
        
        let window = UIWindow.init()
        
        _ = sut.view
        window.addSubview(sut.view)
        
        let helper = sut.children.filter{$0 is NoteCreateViewController}.first as? NoteCreateViewController
        
        helper!.textField.becomeFirstResponder()
        
        assert(helper!.textField.isFirstResponder)
        
        sut.onTableClick("any")
        
        XCTAssertFalse(helper!.textField.isFirstResponder)
    }
    
    // MARK: Spies
    class ReloadTableDelegateSpy: ReloadDelegate {
        
        var shouldReloadCalled = false
        
        func reload() {
            shouldReloadCalled = true
        }
    }
}
