//
//  NoteDetailsVC+LocationManagerDelegate.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/19/21.
//

import UIKit
extension NoteDetailsVC: LocationManagerDelegate{
    func userAddressUpdated(address: String) {
        DispatchQueue.main.async {
            self.mainView.addLocationButton.setTitle(address, for: .normal)
            self.mainView.addLocationButton.setTitleColor(.black, for: .normal)
        }
    }

    func alertToOpenSettings() {
        Alert.alertToOpenSettings(screen: self)
    }
}
