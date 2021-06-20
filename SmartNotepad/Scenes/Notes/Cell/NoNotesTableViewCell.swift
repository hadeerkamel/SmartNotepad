//
//  NoNotesTableViewCell.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/19/21.
//


import UIKit
class NoNotesTableViewCell: UITableViewCell {
    //MARK: - Properties -
    static let IDENTIFIER = "NoNotesTableViewCell"
    var addButtonTapped: (()->())?
    //MARK: - Life cyce -
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    //MARK: - Actions -
    @objc private func addButtonDidTapped(){
        addButtonTapped?()
    }
    //MARK: - Setup views -
    func setupViews(){
        selectionStyle = .none
        contentView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }

        contentView.addSubview(noteimageView)
        noteimageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(messageLabel.snp.top).inset(-20)
        }

        contentView.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.top.equalTo(messageLabel.snp.bottom).inset(-10)
            make.centerX.equalToSuperview()
        }

    }
    //MARK: - UI Components -


   private let noteimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "notes")
        return imageView
    }()

   private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Begin by adding your first note"
        return label
    }()

   private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.contentEdgeInsets = UIEdgeInsets(top: 3, left: 7, bottom: 3, right: 7)

        button.addTarget(self, action: #selector(addButtonDidTapped), for: .touchUpInside)
        return button
    }()
}
