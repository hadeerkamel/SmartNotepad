//
//  NoteDetailsView.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/19/21.
//

import UIKit
class NoteDetailsView: UIView, UITextViewDelegate{
    // MARK: - Properties -
    var data: NoteModel?{
        didSet{
            guard let data = data else { return }

            titleTextFeild.text = data.title
            if let body = data.body, !body.isEmpty{
                bodyTextView.text = body
                textViewPLaceholderLabel.isHidden = true
            }
            if let address = data.address{
                addLocationButton.setTitle(address, for: .normal)
                addLocationButton.setTitleColor(.black, for: .normal)
            }
            if let imageData = data.image,  let image = UIImage(data: imageData){
                self.setNoteImageView(image: image)
            }
        }
    }
    var locationData: LocationData? {
        didSet{
            guard let address = locationData?.address else{return}

            self.addLocationButton.setTitle(address, for: .normal)
            self.addLocationButton.setTitleColor(.black, for: .normal)
        }
    }
    // MARK: - Life cycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        bodyTextView.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    func setNoteImageView(image: UIImage){
        self.noteImageView.image = image
        noteImageView.isHidden = false
        addPhotoButton.isHidden = true
        self.layoutIfNeeded()
    }
    func getNoteModel() -> NoteModel{

        let note = NoteModel()
        note.id = data?.id ?? -1


        note.title = titleTextFeild.text
        note.body = bodyTextView.text
        note.address = (addLocationButton.titleColor(for: .normal) == .black) ?  addLocationButton.title(for: .normal) : nil
        note.image = noteImageView.image?.jpegData(compressionQuality: 0.5)

        note.lat = locationData?.lat ?? data?.lat ?? 0.0
        note.lon = locationData?.lon ?? data?.lon ?? 0.0
        return note
    }

    // MARK: - text view delegate -
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewPLaceholderLabel.isHidden = !(textView.text == nil || textView.text.isEmpty)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        textViewPLaceholderLabel.isHidden = !(textView.text == nil || textView.text.isEmpty)
    }
    func textViewDidChange(_ textView: UITextView) {
        textViewPLaceholderLabel.isHidden = !(textView.text == nil || textView.text.isEmpty)
    }
    // MARK: - SetupViews -
    func setupViews(){
        backgroundColor = .white

        addSubview(locationPhotoStackView)
        locationPhotoStackView.snp.makeConstraints { (make) in
            make.bottom.trailing.equalToSuperview().inset(30)
            make.leading.equalToSuperview().inset( 15 + 25)
        }

        addSubview(iconsStackView)
        iconsStackView.snp.makeConstraints { (make) in
            make.width.equalTo(25)
            make.leading.equalToSuperview()
            make.top.equalTo(locationPhotoStackView.snp.top)
        }

        addSubview(contentStackView)
        contentStackView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(locationPhotoStackView.snp.top).inset(-50)
        }

        addLocationButton.anchor(size: CGSize(width: 0, height: 25))
        addPhotoButton.anchor(size: CGSize(width: 0, height: 25))
        noteImageView.anchor(size: CGSize(width: 0, height: 150))
        locationPhotoStackView.addArrangedSubview(addLocationButton)
        locationPhotoStackView.addArrangedSubview(addPhotoButton)
        locationPhotoStackView.addArrangedSubview(noteImageView)

        imageIconImageView.anchor(size: CGSize(width: 0, height: 25))
        locationIconImageView.anchor(size: CGSize(width: 0, height: 25))
        iconsStackView.addArrangedSubview(locationIconImageView)
        iconsStackView.addArrangedSubview(imageIconImageView)

        contentStackView.addArrangedSubview(titleTextFeild)
        contentStackView.addArrangedSubview(bodyTextView)

        bodyTextView.addSubview(textViewPLaceholderLabel)
        textViewPLaceholderLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview()
        }

    }
    // MARK: - UI Componets -
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    private let titleTextFeild: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Note Title Here",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray.withAlphaComponent(0.7),
                                                                          NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])
        
        textField.font = UIFont.boldSystemFont(ofSize: 17)
        textField.textColor = .black
        return textField
    }()

    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.font =  UIFont.systemFont(ofSize: 17)
        textView.textContainerInset = UIEdgeInsets(top: -3, left: -3, bottom: 0, right: 0)
        return textView
    }()
    private let textViewPLaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Note Body Here"
        label.textColor = .lightGray
        label.font = label.font.withSize(14)
        return label
    }()
    private let iconsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()
    private let locationIconImageView: RoundedImageView = {
         let imageView = RoundedImageView(frame: .zero)
         imageView.image = #imageLiteral(resourceName: "icons8-map-pin-25")
         imageView.tintColor = #colorLiteral(red: 0.2838516533, green: 0.4160010815, blue: 0.9994027019, alpha: 1)
         imageView.layer.borderWidth = 1
         imageView.layer.borderColor = UIColor.blue.cgColor
         imageView.contentMode = .scaleAspectFit
         return imageView
     }()

    private let imageIconImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.contentMode = .scaleAspectFit
         imageView.image = #imageLiteral(resourceName: "image")
         imageView.tintColor = #colorLiteral(red: 0.6833533645, green: 0.67528826, blue: 0.2490542233, alpha: 1)
         return imageView
     }()

    private let locationPhotoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 15
        return stackView
    }()
    let addLocationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Location", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    let addPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Photo", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    lazy var noteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        imageView.isHidden = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
}
