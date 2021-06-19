//
//  Alert.swift
//  Medical-App
//
//  Created by Hadeer Kamel on 1/29/21.
//

import UIKit

class Alert{

    static func LanguageAlert(screen: UIViewController){
        let alert = UIAlertController(title: "ChooseLanguage".localized(), message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "العربية", style: .cancel, handler: {_ in
            LanguageManager.currentLanguage = "ar"
        }))
        alert.addAction(UIAlertAction(title: "English", style: .default, handler: {_ in
            LanguageManager.currentLanguage = "en"
        }))
        screen.present(alert, animated: true, completion: nil)
    }
    static func alertYesOrNO(screen: UIViewController,message: String, yesAction: @escaping()->(), noAction: @escaping()->()){

        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes".localized(), style: .cancel, handler: {_ in
            yesAction()
        }))
        alert.addAction(UIAlertAction(title: "No".localized(), style: .default, handler: {_ in
            noAction()
        }))
        screen.present(alert, animated: true, completion: nil)
    }
    static func alertToOpenSettings(screen: UIViewController){
        let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: UIAlertController.Style.alert)


        let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
            //Redirect to Settings app
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        alertController.addAction(cancelAction)

        alertController.addAction(okAction)

        screen.present(alertController, animated: true, completion: nil)
    }
}
