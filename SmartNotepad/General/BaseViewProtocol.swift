//
//  BaseViewProtocol.swift
//  Medical-App
//
//  Created by Hadeer Kamel on 1/22/21.
//

import UIKit
import NVActivityIndicatorView

protocol BaseViewProtocol {
    func startActivityIndicator()
    func stopActivityIndicator()
}
extension UIViewController: BaseViewProtocol{
    @objc func startActivityIndicator() {
        DispatchQueue.main.async {
            ActivityIndicator.show()
        }
    }
    @objc func stopActivityIndicator(){
        DispatchQueue.main.async {
            ActivityIndicator.dismiss()
        }
    }
}
