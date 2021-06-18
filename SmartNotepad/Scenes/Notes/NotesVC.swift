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
    let mainView: NotesView = {
        let view = NotesView(frame: .zero)
        return view
    }()

}
