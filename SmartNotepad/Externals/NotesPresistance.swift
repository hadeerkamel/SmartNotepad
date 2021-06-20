//
//  NotesPresistance.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/19/21.
//

import Foundation
class NoteModel{
    var id: Int = -1
    var title: String?
    var body: String?
    var address: String?
    var lat: Double?
    var lon: Double?
    var image: Data?
    var createdDate: Date = Date()

    func isEmpty() -> Bool{
        return ((title == nil || title!.isEmpty) && (body == nil || body!.isEmpty) && address == nil && lat == nil && lon == nil && image == nil)
    }
}
class NotesPresistance{
    static var data: [NoteModel] = []

    static func save(note: NoteModel){
        if note.id == -1{
            note.id = data.count
            data.append(note)
        }
    }
    static func delete(note: NoteModel){
        data.removeAll { (note_) -> Bool in
           return note_.id == note.id
        }
    }
    static func edit(note: NoteModel){
        
    }
}
