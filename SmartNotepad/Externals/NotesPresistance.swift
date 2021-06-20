//
//  NotesPresistance.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/19/21.
//

import Foundation
import RealmSwift

class NoteModel: Object{
    @objc dynamic var id: Int = -1
    @objc dynamic var title: String?
    @objc dynamic var body: String?
    @objc dynamic var address: String?
    @objc dynamic var lat: Double = 0.0
    @objc dynamic var lon: Double = 0.0
    @objc dynamic var image: Data?
    @objc dynamic var createdDate: Date = Date()

    override static func primaryKey() -> String? {
        return "id"
    }
    func isEmpty() -> Bool{
        return ((title == nil || title!.isEmpty) && (body == nil || body!.isEmpty) && address == nil && lat == 0.0 && lon == 0.0 && image == nil)
    }
    func copy(from note: NoteModel){
        self.title = note.title
        self.body = note.body
        self.address = note.address
        self.lat = note.lat
        self.lon = note.lon
        self.image = note.image
        self.createdDate = Date()
    }
}
class NotesPresistance{
    static let realm = try! Realm()
    static private var notes: Results<NoteModel> = { realm.objects(NoteModel.self) }()


    static func save(note: NoteModel){
        if note.isEmpty(){
            delete(note: note)
            return
        }

        if note.id == -1{
            note.id = (realm.objects(NoteModel.self).max(ofProperty: "id") as Int? ?? 0) + 1
        }
        try! realm.write() {
            realm.add(note, update: .modified)
        }
    }
    static func delete(note: NoteModel){
        try! realm.write(){
            realm.delete(note)
        }
    }
    static func sorted() -> [NoteModel]{

        var sortedByLocation = sortByNearest()
        var data:[NoteModel] = []
        if let nearest = sortedByLocation.first {
            data = [nearest]
        }
        sortedByLocation.removeFirst()


        let sortedByDate = sortedByLocation.sorted { (note1, note2) -> Bool in
            return note1.createdDate > note2.createdDate
        }

        data.append(contentsOf: sortedByDate)

        return data
    }

    static func sortByNearest() -> [NoteModel]{
        let locationManager = LocationManager(delegate: nil)
        if let currentLocation = locationManager.currentLocation{
            return notes.sorted(by: { LocationData(lat: $0.lat, lon: $0.lon, address: "").distance(to: currentLocation) < LocationData(lat: $1.lat, lon: $1.lon, address: "").distance(to: currentLocation) })
        }else{
            return Array(notes)
        }
    }
}
