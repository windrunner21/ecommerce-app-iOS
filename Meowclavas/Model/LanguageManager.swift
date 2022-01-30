//
//  LanguageManager.swift
//  Meowclavas
//
//  Created by Imran on 31.01.22.
//

import Foundation

class LanguageManager: ObservableObject {
    @Published var lang: String = "en"

    var bundle: Bundle? {
        let b = Bundle.main.path(forResource: lang, ofType: "lproj")!
        return Bundle(path: b)
    }
}
