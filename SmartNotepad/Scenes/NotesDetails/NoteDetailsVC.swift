//
//  NoteDetailsVC.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/19/21.
//

import UIKit
class NoteDetailsVC: UIViewController{
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupViews()
    }
    //MARK: - SetupViews -
    func setupViews(){
        self.view.backgroundColor = .white

        self.view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.top.equalTo(navigationController?.navigationBar.snp.bottom ?? view.snp.top).inset(-30)
            make.leading.trailing.bottom.equalToSuperview().inset(30)
        }
    }
    //MARK: - UI Components -
    let mainView: NoteDetailsView = {
        let view = NoteDetailsView(frame: .zero)
        return view
    }()
}
