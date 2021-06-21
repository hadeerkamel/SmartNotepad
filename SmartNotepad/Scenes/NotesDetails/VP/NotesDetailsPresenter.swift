//
//  NotesDetailsPresenter.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/21/21.
//

import Foundation
protocol NoteDetailsPresenter{
    func saveBeforeDisappearing()
    func deleteNote()
}
class NoteDetailsPresenterImpl: NoteDetailsPresenter{

    let view: NoteDetailsViewProtocol
    var deleted = false
    init(view: NoteDetailsViewProtocol){
        self.view = view
    }

    func saveBeforeDisappearing(){
        if !deleted{
            let model = view.getNoteModel()
                if !model.isEmpty(){
                    NotesPresistance.save(note: model)
                }
        }
    }

    func deleteNote() {
        if let note = view.getNoteModelBeforeEditing(), !note.isEmpty(){
            NotesPresistance.delete(note: note)
            deleted = true
            self.view.popVC()
        }
    }
}
