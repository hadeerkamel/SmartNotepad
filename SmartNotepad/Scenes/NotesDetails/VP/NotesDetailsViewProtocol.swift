//
//  NotesDetailsViewProtocol.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/21/21.
//

import UIKit

protocol NoteDetailsViewProtocol: BaseViewProtocol{
    func getNoteModel() -> NoteModel
    func getNoteModelBeforeEditing() -> NoteModel?
    func popVC()
}
extension NoteDetailsVC: NoteDetailsViewProtocol{
    func getNoteModel() -> NoteModel{
        return mainView.getNoteModel()
    }
    func getNoteModelBeforeEditing() -> NoteModel?{
        return mainView.data
    }
    func popVC(){
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
