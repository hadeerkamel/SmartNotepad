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
    }
    // MARK: - UI Componets -
}
