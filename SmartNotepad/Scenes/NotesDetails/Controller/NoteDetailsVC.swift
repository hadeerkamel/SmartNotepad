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
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imageSelector = ImageSelectorImpl()
        locationManager = LocationManager(delegate: self)
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
        view.addLocationButton.addTarget(self, action: #selector(addLocationButtonDidTapped), for: .touchUpInside)
        view.addPhotoButton.addTarget(self, action: #selector(addPhotoButtonDidTapped), for: .touchUpInside)
        return view
    }()
}
