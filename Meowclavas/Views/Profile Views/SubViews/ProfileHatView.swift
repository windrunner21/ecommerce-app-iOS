//
//  ProfileHatView.swift
//  Meowclavas
//
//  Created by Imran on 14.12.21.
//

import SwiftUI

struct ProfileHatView: View {
    let fullName = UserDefaults.standard.string(forKey: "userFullName")
    
    @State private var userQuotes: [String] = [
        NSLocalizedString("The secret of getting ahead is getting started.", comment: ""),
        NSLocalizedString("Everything you can imagine is real.", comment: ""),
        NSLocalizedString("Do one thing every day that scares you.", comment: ""),
        NSLocalizedString("Do what you feel in your heart to be right – for you’ll be criticized anyway.", comment: ""),
        NSLocalizedString("Whatever you are, be a good one.", comment: "")
    ]
    
    // random picture generator
    @State private var randomInt = Int.random(in: 1..<4)
    
    var body: some View {
        VStack {
            ZStack {
                Image("Profile Background")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: UIScreen.main.bounds.size.width,
                        height: UIScreen.main.bounds.size.height / 2.5
                    )
                    .clipped()
                    .blur(radius: 0.8)
                
                VStack(spacing: 10.0) {
                    Image("Profile Picture_\(randomInt)")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay {
                            Circle().stroke(.white, lineWidth: 4)
                        }
                        .shadow(radius: 7)
                    
                    Text(fullName ?? "Name Not Found")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                    
                    Text(userQuotes.randomElement() ?? "Average balaclavas enjoyer.")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                }
                .padding()
            }
            
            Spacer()
        }
        .background(Color(UIColor.secondarySystemBackground))
        .ignoresSafeArea()
    }
}

struct ProfileHatView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHatView()
            .environmentObject(UserManager())
    }
}
