//
//  NoteDetailsVC+ImageSelectorDelegate.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/19/21.
//

import UIKit
extension NoteDetailsVC: ImageSelectorDelegate{

    func didSelectImage(image: UIImage) {
        mainView.setNoteImageView(image: image)
    }

    func presentImagePicker(imagepicker: UIImagePickerController) {
        self.present(imagepicker, animated: true, completion: nil)
    }

    func presentActionSheet(actionSheet: UIAlertController) {
        self.present(actionSheet, animated: true, completion: nil)
    }
}
