@testable import EasyList
import XCTest
import RealmSwift

class NoteTableViewControllerTests: XCTestCase {
    
    let sut = NoteTableViewController()
    let interactor = NoteTableInteractorSpy()
    
    func test_viewDidLoad_loads_table() {

        _ = sut.view
        XCTAssertNotNil(sut.tableView)
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertNotNil(sut.tableView.dequeueReusableCell(withIdentifier: sut.cellId))
    }
    
    class NoteTableInteractorSpy: NoteTableInteractorLogic {
        var worker: NoteRepositoryLogic = NoteWorker()
        
        var fetchDataSourceCalled = false

        func fetchDataSource() -> Results<NoteModel>? {
            fetchDataSourceCalled = true
            return nil
        }
    }
}
