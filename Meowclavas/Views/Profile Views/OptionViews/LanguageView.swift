//
//  LanguageView.swift
//  Meowclavas
//
//  Created by Imran on 30.01.22.
//

import SwiftUI

struct LanguageView: View {
    @EnvironmentObject var langManager: LanguageManager
    
    var body: some View {
//        VStack {
//            Text("The secret of getting ahead is getting started.", bundle: langManager.bundle)
//            Button("Change") {
//                langManager.lang = "ru"
//            }
//        }
        Text("Navigate to iPhone settings to change the language. ❤️")
        .padding()
    }
}

struct LanguageView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageView()
    }
}
