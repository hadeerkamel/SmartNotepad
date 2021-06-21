//
//  NotesVC+TableDelegate.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/21/21.
//

import UIKit

extension NotesVC: UITableViewDelegate{
    func setupTableView(){
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.IDENTIFIER)
        tableView.register(NoNotesTableViewCell.self, forCellReuseIdentifier: NoNotesTableViewCell.IDENTIFIER)
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        data.asObservable()
            .bind(to: tableView.rx.items){ (tableView, row, item) -> UITableViewCell in
                if self.data.value.count == 1, item.isEmpty(){
                    let cell = tableView.dequeueReusableCell(withIdentifier: NoNotesTableViewCell.IDENTIFIER, for: IndexPath(row: 0, section: 0)) as! NoNotesTableViewCell
                   cell.addButtonTapped = self.didTapAddButton
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.IDENTIFIER, for: IndexPath(row: row, section: 0)) as! NoteTableViewCell
                    cell.data = item
                    cell.nearstLabel.isHidden = (row != 0)
                    return cell
                }
            }.disposed(by: disposeBag)
        tableView.rx
            .modelSelected(NoteModel.self)
            .subscribe(onNext:  { value in
                self.didSelectNote(note: value)
            })
            .disposed(by: disposeBag)
    }
    func didSelectNote(note: NoteModel){
        if !(data.value.count == 1 && note.isEmpty()){
         self.navigationController?.pushViewController(NoteDetailsVC(note: note), animated: true)
        }
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (data.value.count == 1 && data.value[0].isEmpty()) ? view.frame.height : 70
    }

}
