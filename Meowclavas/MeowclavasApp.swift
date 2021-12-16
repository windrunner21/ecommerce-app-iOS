//
//  MeowclavasApp.swift
//  Meowclavas
//
//  Created by Imran on 10.12.21.
//

import SwiftUI

@main
struct MeowclavasApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
