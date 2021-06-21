//
//  NotesVC.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/18/21.
//

import UIKit
import RxSwift
import RxCocoa

class NotesVC: UIViewController{
    //MARK: - Propertis -
    var presenter: NotesPresenter?
    var data: BehaviorRelay<[NoteModel]> = BehaviorRelay(value: [])
    var disposeBag = DisposeBag()
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Notes"
       // print(NotesPresistance.realm.configuration.fileURL)
        presenter = NotesPresenterImpl(view: self)
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden((data.value.count == 1 && data.value[0].isEmpty()), animated: false)
        presenter?.presentNotes()
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
