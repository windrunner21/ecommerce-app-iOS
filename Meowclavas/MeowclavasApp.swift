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
    @ObservedObject var baggies = Baggies()
    @ObservedObject var favorites = Favorites()
    @ObservedObject var shipment = Shipping()
    @ObservedObject var langManager = LanguageManager()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .environmentObject(userManager)
                .environmentObject(baggies)
                .environmentObject(favorites)
                .environmentObject(shipment)
                .environmentObject(langManager)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
