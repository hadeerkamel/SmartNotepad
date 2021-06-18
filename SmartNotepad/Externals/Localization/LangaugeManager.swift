//
//  LangaugeManager.swift
//  Medical-App
//
//  Created by Hadeer Kamel on 1/7/21.
//

import Foundation
struct LanguageManager {
   static var currentLanguage: String {
        get {
            return LocalizationSystem.sharedInstance.getLanguage()
        }set {
            if currentLanguage != newValue{
                LocalizationSystem.sharedInstance.setLanguage(languageCode: newValue)
            }
        }
    }
    static func localizedStringForKey(key: String, comment: String) -> String{
       return LocalizationSystem.sharedInstance.localizedStringForKey(key: key, comment: comment)
    }

}
