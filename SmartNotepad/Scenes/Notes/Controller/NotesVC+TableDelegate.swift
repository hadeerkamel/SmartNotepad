//
//  NotesVC+TableDelegate.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/21/21.
//

import UIKit

extension NotesVC: UITableViewDelegate, UITableViewDataSource{
    func setupTableView(){
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.IDENTIFIER)
        tableView.register(NoNotesTableViewCell.self, forCellReuseIdentifier: NoNotesTableViewCell.IDENTIFIER)

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{

        tableView.separatorStyle = data.isEmpty ? .none : .singleLine
        tableView.isScrollEnabled = !data.isEmpty
        self.navigationController?.setNavigationBarHidden(data.isEmpty, animated: false)

        return data.isEmpty ? 1 : data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if data.isEmpty{
            let cell = tableView.dequeueReusableCell(withIdentifier: NoNotesTableViewCell.IDENTIFIER, for: indexPath) as! NoNotesTableViewCell
            cell.addButtonTapped = self.didTapAddButton
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.IDENTIFIER, for: indexPath) as! NoteTableViewCell
        cell.data = data[indexPath.row]
        cell.nearstLabel.isHidden = (indexPath.row != 0)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return data.isEmpty ? view.frame.height : 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !data.isEmpty{
         self.navigationController?.pushViewController(NoteDetailsVC(note: data[indexPath.row]), animated: true)
        }
    }

}
