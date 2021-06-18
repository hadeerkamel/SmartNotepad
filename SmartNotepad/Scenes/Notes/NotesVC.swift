//
//  NotesVC.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/18/21.
//

import UIKit
class NotesVC: UIViewController{
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.IDENTIFIER)
        tableView.dataSource = self
        tableView.delegate = self

    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupViews()
    }
    //MARK: - SetupViews -
    func setupViews(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }

    }
    //MARK: - UI Components -
    let mainView: NotesView = {
        let view = NotesView(frame: .zero)
        return view
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
//        tableView.rowHeight = 70
//        tableView.estimatedRowHeight = 70
        tableView.tableFooterView = UIView()

//        tableView.separatorColor = .darkGray
//        tableView.separatorStyle = .singleLine
//        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()
}

extension NotesVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.IDENTIFIER, for: indexPath) as! NoteTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
   
}
