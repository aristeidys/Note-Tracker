//
//  NoteInteractor.swift
//  EasyList
//
//  Created by Aristeidis Panagiotopoulos on 23/10/2018.
//  Copyright (c) 2018 arisPanagiotopoulos. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol NoteBusinessLogic
{
  func newNote(request: Note.Create.Request)
}

protocol NoteDataStore {
    //var name: String { get set }
}

class NoteInteractor: NoteBusinessLogic, NoteDataStore {
 
	var presenter: NotePresentationLogic?
	var worker: NoteRepositoryLogic = NoteWorker()

  
	func newNote(request: Note.Create.Request) {
    let response = Note.Create.Response()
	
	worker.createNote(title: request.title, text: request.text)
    presenter?.presentSomething(response: response)
  }
}
