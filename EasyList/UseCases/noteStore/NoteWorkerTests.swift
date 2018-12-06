@testable import EasyList
import XCTest


class NoteWorkerTests: RepositoryBaseTestCase
{
    // MARK: Subject under test
    
    var sut: NoteWorker = NoteWorker()
    
    let dummyNote = NoteModel(title: "hello", text: "world")

    override func setUp() {
        deleteAllData()
    }
    
    // MARK: Tests
    
    func test_NoteWorker_Should_Create_EmptyNote() {
        sut.createNote(NoteModel())
        noteShouldHave()
    }
    
    func test_NoteWorker_Should_Create_Note_With_Title() {
        sut.createNote(NoteModel(title: "hi"))
        noteShouldHave(title: "hi")
    }
    
    func test_NoteWorker_Should_Create_Note_With_Text() {
        sut.createNote(NoteModel(text: "hello"))
        noteShouldHave(text: "hello")
    }
    
    func test_NoteWorker_Should_Create_Note_With_Title_And_Text() {
        sut.createNote(dummyNote)
        noteShouldHave(title: "hello", text: "world")
    }
    
    func test_noteWorker_should_fetch_allNotes() {
        sut.createNote(dummyNote)
        
        let allNotes = sut.getAll()
        
        XCTAssertEqual(1, allNotes!.count)
        
        sut.createNote(NoteModel(title: "hello"))
        
        XCTAssertEqual(2, allNotes!.count)
    }
    
    func test_noteWorker_should_delete_one_Note() {
        
        sut.createNote(dummyNote)
    
        sut.deleteNote(dummyNote)
        let allNotes2 = sut.getAll()
        
        XCTAssertEqual(0, allNotes2!.count)
    }
    
    func test_noteWorker_should_not_delete_nil_Note() {
        
        sut.createNote(dummyNote)
        
        sut.deleteNote(nil)
        let allNotes2 = sut.getAll()
        
        XCTAssertEqual(1, allNotes2!.count)
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
