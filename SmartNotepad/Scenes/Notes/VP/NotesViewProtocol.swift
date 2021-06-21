//
//  NotesViewProtocol.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/21/21.
//

import UIKit

protocol NotesViewProtocol: BaseViewProtocol{
    func gotNotes(notes: [NoteModel])
}
extension NotesVC: NotesViewProtocol{
    func gotNotes(notes: [NoteModel]) {
        DispatchQueue.main.async {
            self.data = notes
            self.tableView.reloadData()
        }
    }
}
