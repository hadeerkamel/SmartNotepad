//
//  ActivityIndicator.swift
//  Medical-App
//
//  Created by Hadeer Kamel on 1/22/21.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class ActivityIndicator{
    static var activityIndicator: NVActivityIndicatorView?

    static private func initActivityIndicator(){
        guard let window = UIApplication.shared.windows.last else { return }

        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: window.frame.midX - 50 , y: window.frame.midY - 50, width: 100, height: 100), type: .orbit,color: UIConstants.Colors.AppMainColor, padding: 5.0)

        window.addSubview(activityIndicator!)
    }
    static func show(){
        if activityIndicator == nil{
            initActivityIndicator()
        }
        activityIndicator?.startAnimating()
    }
    static func dismiss(){
        activityIndicator?.stopAnimating()
    }
}
