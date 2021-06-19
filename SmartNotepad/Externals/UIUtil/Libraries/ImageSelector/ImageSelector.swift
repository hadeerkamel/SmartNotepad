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
    var source: ImageSelectorSource = .both
  let presentationStyle: ImageSelectorPresentationStyle
  let isAllowingEditting: Bool
  let delegate: ImageSelectorDelegate
}

enum ImageSelectorSource {
  case photo
  case camera
  case both
  var source: UIImagePickerController.SourceType {
    if self == .photo{
        return .photoLibrary
    }else if self == .camera{
        return .camera
    }else{
        return .camera
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
