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
        self.view.addSubview(mainView)
        mainView.fillSuperview()
    }
    //MARK: - UI Components -
    let mainView: NoteDetailsView = {
        let view = NoteDetailsView(frame: .zero)
        return view
    }()
}
