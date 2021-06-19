//
//  NoteDetailsVC.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/19/21.
//

import UIKit
import CoreLocation
class NoteDetailsVC: UIViewController, CLLocationManagerDelegate, ImageSelectorDelegate{
    func presentImagePicker(imagepicker: UIImagePickerController) {
        self.present(imagepicker, animated: true, completion: nil)
    }

    func presentActionSheet(actionSheet: UIAlertController) {
        self.present(actionSheet, animated: true, completion: nil)
    }

    //MARK: - Properties -
    var locationManager: CLLocationManager?
    var checkLocationAuthStatusChange = false
    var imageSelector: ImageSelector?
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self

        imageSelector = ImageSelectorImpl()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupViews()
    }
    //MARK: - Actions -
    @objc func addLocationButtonDidTapped(){
        locationManager?.requestWhenInUseAuthorization()
        checkLocationAuthStatusChange = true

            if CLLocationManager.authorizationStatus() == .denied{
                Alert.alertToOpenSettings(screen: self)
            }else{
                getAddressFromLatLon(lat: locationManager?.location?.coordinate.latitude ?? 0.0, withLongitude: locationManager?.location?.coordinate.longitude ?? 0.0)
            }
    }
    @objc func addPhotoButtonDidTapped(){
        var inputs = ImageSelectorInputs(presentationStyle: .fullscreen, isAllowingEditting: false, delegate: self)
        inputs.source = .photo
        imageSelector?.pickImage(with: inputs)
    }

    // image selector delegate
    func didSelectImage(image: UIImage) {
        mainView.setNoteImageView(image: image)
    }
    //Location delegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if checkLocationAuthStatusChange,  status == .denied {
            Alert.alertToOpenSettings(screen: self)
            checkLocationAuthStatusChange = false
        }
        else if checkLocationAuthStatusChange{
            getAddressFromLatLon(lat: locationManager?.location?.coordinate.latitude ?? 0.0, withLongitude: locationManager?.location?.coordinate.longitude ?? 0.0)
        }
    }
    func getAddressFromLatLon(lat: Double, withLongitude lon: Double){
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()

        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon

        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)


        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
                                        if (error != nil)
                                        {
                                            print("reverse geodcode fail: \(error!.localizedDescription)")
                                        }
                                        let pm = placemarks! as [CLPlacemark]

                                        if pm.count > 0 {
                                            let pm = placemarks![0]

                                            var addressString : String = ""
                                            if pm.subLocality != nil {
                                                addressString = addressString + pm.subLocality! + ", "
                                            }

                                            if pm.locality != nil {
                                                addressString = addressString + pm.locality! + ", "
                                            }
                                            if pm.country != nil {
                                                addressString = addressString + pm.country!
                                            }

                                            DispatchQueue.main.async {
                                                self.mainView.addLocationButton.setTitle(addressString, for: .normal)
                                                self.mainView.addLocationButton.setTitleColor(.black, for: .normal)
                                            }

                                        }
                                    })

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
