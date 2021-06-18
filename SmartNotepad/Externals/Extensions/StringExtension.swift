//
//  StringExtension.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/18/21.
//

import UIKit

extension String {
    func localized() -> String{
        return LanguageManager.localizedStringForKey(key: self, comment: "")
    }
}
