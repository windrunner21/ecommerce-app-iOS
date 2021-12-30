//
//  ContentView.swift
//  Meowclavas
//
//  Created by Imran on 10.12.21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var tabSelection: Tab = .featured
    
    var body: some View {
        Group {
            if userManager.authState == .loggedOut {
                LoginView()
            } else {
                TabView(selection: $tabSelection) {
                    FeaturedView()
                        .tabItem {
                            Label("Featured", systemImage: "square.stack.3d.up")
                        }
                        .tag(Tab.featured)
                    
                    ExploreView()
                        .tabItem {
                            Label("Explore", systemImage: "eye.fill")
                        }
                        .tag(Tab.explore)
                    
                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person.circle")
                        }
                        .tag(Tab.profile)
                }
                .accentColor(.primary)
            }
        }
        .animation(.easeIn, value: userManager.authState)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
            .environmentObject(UserManager())
    }
}
