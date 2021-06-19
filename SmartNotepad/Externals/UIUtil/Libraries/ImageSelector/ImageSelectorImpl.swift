//
//  ImageSelectorImpl.swift
//  Medical-App
//
//  Created by Hadeer Kamel on 2/6/21.
//

import Foundation
import UIKit

class ImageSelectorImpl: NSObject, ImageSelector, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var delegate: ImageSelectorDelegate?
    private var inputs: ImageSelectorInputs?
    private var systemUtil: SystemUtil = SystemUtilsImpl()
    //let presentingViewController: UIViewController

    override init() {
        // self.presentingViewController = presentingViewController
    }

    func pickImage(with inputs: ImageSelectorInputs) {

        delegate = inputs.delegate
        self.inputs = inputs
        if inputs.source == .camera{
            self.presentImagePicker(with: .camera)
        }else if inputs.source == .photo{
            self.presentImagePicker(with: .photo)
        }else{
            showActionSheet()
        }


    }
    private func presentImagePicker(with source: ImageSelectorSource){
        if source == .camera && !systemUtil.isCameraAvailable{
            return
        }
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = inputs!.isAllowingEditting
        picker.sourceType = source.source
        picker.modalPresentationStyle = inputs!.presentationStyle.style
        delegate?.presentImagePicker(imagepicker: picker)
    }
    private func showActionSheet(){

        //Create the AlertController and add Its action like button in Actionsheet
        let actionSheetController: UIAlertController = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        actionSheetController.view.tintColor = UIColor.black
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel".localized(), style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)

        let saveActionButton: UIAlertAction = UIAlertAction(title: "TakePhoto".localized(), style: .default)
        { action -> Void in
            self.presentImagePicker(with: .camera)
        }
        actionSheetController.addAction(saveActionButton)

        let deleteActionButton: UIAlertAction = UIAlertAction(title: "Photos".localized(), style: .default)
        { action -> Void in
            self.presentImagePicker(with: .photo)
        }
        actionSheetController.addAction(deleteActionButton)
        delegate?.presentActionSheet(actionSheet: actionSheetController)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        guard let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else {

            picker.dismiss(animated: true, completion: nil)
            return
        }

        delegate?.didSelectImage(image: image)

        picker.dismiss(animated: true, completion: nil)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

