//
//  NoteTableViewCell.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/18/21.
//

import UIKit
class NoteTableViewCell: UITableViewCell {
    //MARK: - Properties -
    static let IDENTIFIER = "NoteTableViewCell"

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
        superview?.layoutSubviews()
        setupViews()
    }
    //MARK: - Setup views -
    func setupViews(){

        contentView.addSubview(contentStackView)
        contentStackView.snp.makeConstraints { (make) in
            make.top.bottom.leading.equalToSuperview().inset(10)
        }
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(bodyLabel)

        contentView.addSubview(infoStackView)
        infoStackView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(25)
        }
        locationIconImageView.anchor(size: CGSize(width: 25, height: 0))
        imageIconImageView.anchor(size: CGSize(width: 25, height: 0))
        
        infoStackView.addArrangedSubview(nearstLabel)
        infoStackView.addArrangedSubview(locationIconImageView)
        infoStackView.addArrangedSubview(imageIconImageView)
    }
    //MARK: - UI Components -

    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .black
        label.text = "Note title"
        return label
    }()

    let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(15)
        label.textColor = .lightGray
        label.text = "Note body"
        return label
    }()

    let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 15
        return stackView
    }()
    let nearstLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.3144574165, green: 0.8099127412, blue: 0.4401344061, alpha: 1)
        label.text = "Nearest".localized()
        label.font = label.font.withSize(14)
        return label
    }()

    let locationIconImageView: RoundedImageView = {
        let imageView = RoundedImageView(frame: .zero)
        imageView.image = #imageLiteral(resourceName: "icons8-map-pin-25")
        imageView.tintColor = #colorLiteral(red: 0.2838516533, green: 0.4160010815, blue: 0.9994027019, alpha: 1)
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.blue.cgColor
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let imageIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "image")
        imageView.tintColor = #colorLiteral(red: 0.6833533645, green: 0.67528826, blue: 0.2490542233, alpha: 1)
        return imageView
    }()
}
