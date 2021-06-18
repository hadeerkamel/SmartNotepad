//
//  NotesView.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/18/21.
//

import UIKit
class NotesView: UIView{
    // MARK: - Properties -

    // MARK: - Life cycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    // MARK: - SetupViews -
    func setupViews(){
        backgroundColor = .white

        addSubview(tableView)
       // tableView.fillSuperview()
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
    }
    // MARK: - UI Componets -
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
