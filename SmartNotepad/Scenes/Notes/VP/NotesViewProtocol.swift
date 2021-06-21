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
            self.data.accept(notes.isEmpty ? [NoteModel()] : notes)
            self.tableView.separatorStyle = notes.isEmpty ? .none : .singleLine
            self.tableView.isScrollEnabled = !notes.isEmpty
            self.navigationController?.setNavigationBarHidden(notes.isEmpty, animated: false)
            self.tableView.reloadData()
        }
    }
}
