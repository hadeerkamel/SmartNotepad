//
//  RoundedImageView.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/19/21.
//


import UIKit

class RoundedImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        makeRoundedImage()
    }
    func makeRoundedImage() {
        self.layer.cornerRadius = self.frame.height / 2.0
        self.clipsToBounds = true
    }
}
