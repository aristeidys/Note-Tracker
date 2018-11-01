@testable import EasyList
import XCTest


class NoteWorkerTests: RepositoryBaseTestCase
{
    // MARK: Subject under test
    
    var sut: NoteWorker = NoteWorker()
    
    override func setUp() {
        deleteAllData()
    }
    
    // MARK: Tests
    
    func test_NoteWorker_Should_Create_EmptyNote() {
        sut.createNote()
        noteShouldHave()
    }
    
    func test_NoteWorker_Should_Create_Note_With_Title() {
        sut.createNote(title: "hi")
        noteShouldHave(title: "hi")
    }
    
    func test_NoteWorker_Should_Create_Note_With_Text() {
        sut.createNote(text: "hello")
        noteShouldHave(text: "hello")
    }
    
    func test_NoteWorker_Should_Create_Note_With_Title_And_Text() {
        sut.createNote(title: "hello", text: "world")
        noteShouldHave(title: "hello", text: "world")
    }
    
    func test_noteWorker_should_fetch_allNotes() {
        sut.createNote(title: "hello", text: "world")
        
        let allNotes = sut.getAll()
        
        XCTAssertEqual(1, allNotes!.count)
        
        sut.createNote(title: "hello")
        
        XCTAssertEqual(2, allNotes!.count)
    }
    
    
    func noteShouldHave(title: String = "", text: String = "") {
        let queryResult = realm.objects(NoteModel.self)
        XCTAssertEqual(1, queryResult.count, "1 Note Should Exist")
        let result = queryResult[0]
        XCTAssertEqual(title, result.title)
        XCTAssertEqual(text, result.text)
        XCTAssertNotNil(result.id)
        XCTAssertNotNil(result.editedDate)
    }
}