//
//  ImageSelector.swift
//  Medical-App
//
//  Created by Hadeer Kamel on 2/6/21.
//

import Foundation
import UIKit

protocol ImageSelector {
  func pickImage(with inputs: ImageSelectorInputs)
}

struct ImageSelectorInputs {
  //let source: ImageSelectorSource
  let presentationStyle: ImageSelectorPresentationStyle
  let isAllowingEditting: Bool
  let delegate: ImageSelectorDelegate
}

enum ImageSelectorSource {
  case photo
  case camera

  var source: UIImagePickerController.SourceType {
    switch self {
    case .photo: return .photoLibrary
    case .camera: return .camera
    }
  }
}

enum ImageSelectorPresentationStyle {
  case fullscreen

  var style: UIModalPresentationStyle {
    return .overFullScreen
  }
}

protocol ImageSelectorDelegate {
  func didSelectImage(image: UIImage)
  func presentImagePicker(imagepicker: UIImagePickerController)
  func presentActionSheet(actionSheet: UIAlertController)
}


protocol SystemUtil {
  var isCameraAvailable: Bool {get}
}

class SystemUtilsImpl: SystemUtil {

  static let shared: SystemUtilsImpl = SystemUtilsImpl()

  var isCameraAvailable: Bool {
     return UIImagePickerController.isSourceTypeAvailable(.camera)
  }
}
