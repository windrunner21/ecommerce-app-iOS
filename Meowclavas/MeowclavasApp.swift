//
//  MeowclavasApp.swift
//  Meowclavas
//
//  Created by Imran on 10.12.21.
//

import SwiftUI
import Firebase

@main
struct MeowclavasApp: App {
    @StateObject private var modelData = ModelData()
    @StateObject private var userManager = UserManager()
    @StateObject private var dataController = DataController()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .environmentObject(userManager)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
