//
//  ContentView.swift
//  Meowclavas
//
//  Created by Imran on 10.12.21.
//

import SwiftUI

struct ContentView: View {
    @State private var authState: Authorization = .loggedIn
    @State private var tabSelection: Tab = .featured
    
    var body: some View {
        Group {
            if authState == .loggedOut {
                LoginView(authState: $authState)
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
        .animation(.easeIn, value: authState)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
