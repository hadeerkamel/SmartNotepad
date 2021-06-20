//
//  NotesVC.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/18/21.
//

import UIKit
import RealmSwift

class NotesVC: UIViewController{
    //MARK: - Propertis -
    var data: Results<NoteModel> = NotesPresistance.notes
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Notes"

        print(NotesPresistance.realm.configuration.fileURL)
        
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.IDENTIFIER)
        tableView.register(NoNotesTableViewCell.self, forCellReuseIdentifier: NoNotesTableViewCell.IDENTIFIER)

        tableView.dataSource = self
        tableView.delegate = self

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(data.isEmpty, animated: false)

        data = NotesPresistance.notes
        tableView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupViews()
    }
    //MARK: - Actions -
    @objc func didTapAddButton(){
        self.navigationController?.pushViewController(NoteDetailsVC(note: NoteModel()), animated: true)
    }
    //MARK: - SetupViews -
    func setupViews(){
        view.addSubview(tableView)
        tableView.fillSuperview()

        self.navigationItem.rightBarButtonItem =  UIBarButtonItem(customView: addNewNoteButton)
    }
    //MARK: - UI Components -
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    lazy var addNewNoteButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        return button
    }()
}

extension NotesVC: UITableViewDelegate, UITableViewDataSource{
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
