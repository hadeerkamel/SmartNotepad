//
//  NotesPresenter.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/21/21.
//

import Foundation
protocol NotesPresenter{
    func presentNotes()
}
class NotesPresenterImpl: NotesPresenter{

    let view: NotesViewProtocol
    init(view: NotesViewProtocol){
        self.view = view
    }

    func presentNotes(){
        let data = NotesPresistance.sorted()
        self.view.gotNotes(notes: data)
    }
}
