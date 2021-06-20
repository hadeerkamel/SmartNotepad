//
//  NoteDetailsVC.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/19/21.
//

import UIKit

class NoteDetailsVC: UIViewController{

    //MARK: - Properties -
    var locationManager: LocationManager?
    var imageSelector: ImageSelector?
    var deleted = false
    //MARK: - Life cycle
    init(note: NoteModel?){
        super.init(nibName: nil, bundle: nil)
        mainView.data = note
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageSelector = ImageSelectorImpl()
        locationManager = LocationManager(delegate: self)
    }
    override func viewWillDisappear(_ animated: Bool) {
        if !deleted{
            let model = mainView.getNoteModel()
                if !model.isEmpty(){
                    NotesPresistance.save(note: model)
                }
        }
        super.viewWillDisappear(animated)
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupViews()
    }
    //MARK: - Actions -
    @objc func addLocationButtonDidTapped(){
        locationManager?.detectUserAddress()
    }
    @objc func addPhotoButtonDidTapped(){
        var inputs = ImageSelectorInputs(presentationStyle: .fullscreen, isAllowingEditting: false, delegate: self)
        inputs.source = .photo
        imageSelector?.pickImage(with: inputs)
    }
    @objc func deleteButtonDidTapped(){
        if let note = mainView.data, !note.isEmpty(){
            NotesPresistance.delete(note: note)
            deleted = true
            self.navigationController?.popViewController(animated: true)
        }
    }
    //MARK: - SetupViews -
    func setupViews(){
        self.view.backgroundColor = .white

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: deleteButton)

        self.view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.top.equalTo(navigationController?.navigationBar.snp.bottom ?? view.snp.top).inset(-30)
            make.leading.trailing.bottom.equalToSuperview().inset(30)
        }
    }
    //MARK: - UI Components -
    let mainView: NoteDetailsView = {
        let view = NoteDetailsView(frame: .zero)
        view.addLocationButton.addTarget(self, action: #selector(addLocationButtonDidTapped), for: .touchUpInside)
        view.addPhotoButton.addTarget(self, action: #selector(addPhotoButtonDidTapped), for: .touchUpInside)
        view.noteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addPhotoButtonDidTapped)))
        return view
    }()
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "baseline_delete_outline_black_24pt"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(deleteButtonDidTapped), for: .touchUpInside)
        return button
    }()
}
