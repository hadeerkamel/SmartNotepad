//
//  NoteDetailsVC+LocationManagerDelegate.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/19/21.
//

import UIKit
extension NoteDetailsVC: LocationManagerDelegate{
    func userAddressUpdated(data: LocationData) {
        DispatchQueue.main.async {
            self.mainView.locationData = data
        }
    }

    func alertToOpenSettings() {
        Alert.alertToOpenSettings(screen: self)
    }
}
