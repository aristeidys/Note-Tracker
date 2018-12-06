@testable import EasyList
import XCTest
import RealmSwift

class NoteTableInteractorTests: XCTestCase {
    
    func test_fetchDataSource_calls_noteWorker() {
        let sut = NoteTableInteractor()
        let worker = NoteWorkerSpy()
        sut.worker = worker
        
        _ = sut.fetchDataSource()
        
        assert(worker.getAllCalled)
    }
    
    class NoteWorkerSpy: NoteRepositoryLogic {
        func createNote(_ note: NoteModel) {
            
        }
        var getAllCalled = false
        func getAll() -> Results<NoteModel>? {
            getAllCalled = true
            return nil
        }
        
        
        
    }
}
