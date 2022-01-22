//
//  ProfileOptionsView.swift
//  Meowclavas
//
//  Created by Imran on 14.12.21.
//

import SwiftUI
import Firebase

struct ProfileOptionsView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var showingAlert: Bool = false
    
    var body: some View {
        VStack {
            // main settings - address and personal data
            VStack {
                NavigationLink {
                    AddressView()
                } label: {
                    OptionRowView(
                        iconSystemName: "mappin",
                        optionName: "My Address",
                        navigationLink: true
                    )
                }
                
                Divider()
                    .padding(.horizontal)
                
                NavigationLink {
                    AccountView()
                } label: {
                    OptionRowView(
                        iconSystemName: "person.fill",
                        optionName: "Account",
                        navigationLink: true
                    )
                }
            }
            .foregroundColor(Color(UIColor.systemGray))
            .padding(.vertical)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(10)
            .padding([.bottom, .horizontal])
            
            // additional settigns - language history
            VStack {
                NavigationLink {
                    AddressView()
                } label: {
                    OptionRowView(
                        iconSystemName: "shippingbox.fill",
                        optionName: "My Orders",
                        navigationLink: true
                    )
                }
                
                Divider()
                    .padding(.horizontal)
                
                NavigationLink {
                    AddressView()
                } label: {
                    OptionRowView(
                        iconSystemName: "globe",
                        optionName: "Language",
                        navigationLink: true
                    )
                }
            }
            .foregroundColor(Color(UIColor.systemGray))
            .padding(.vertical)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(10)
            .padding(.horizontal)
            
            Button(action: {
                showingAlert = true
            }) {
                OptionRowView(
                    iconSystemName: "arrow.left.circle.fill",
                    optionName: "Sign Out",
                    navigationLink: false
                )
                    .foregroundColor(.red)
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(10)
                    .padding([.top, .horizontal])
            }
            .alert(isPresented:$showingAlert) {
                Alert(
                    title: Text("Are you sure you want to sign out?"),
                    message: Text("You will need to sing in again to use the application."),
                    primaryButton: .destructive(Text("Sign Out")) {
                        userManager.signOutUser()
                    },
                    secondaryButton: .cancel()
                )
            }

        }
    }
}

struct ProfileOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileOptionsView()
    }
}
