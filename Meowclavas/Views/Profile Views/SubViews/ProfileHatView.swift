//
//  ProfileHatView.swift
//  Meowclavas
//
//  Created by Imran on 14.12.21.
//

import SwiftUI

struct ProfileHatView: View {
    @State private var userQuotes: [String] = [
        "The secret of getting ahead is getting started.",
        "Everything you can imagine is real.",
        "Do one thing every day that scares you.",
        "Do what you feel in your heart to be right – for you’ll be criticized anyway.",
        "Whatever you are, be a good one."
    ]
    
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
                    Image("Profile Picture")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay {
                            Circle().stroke(.white, lineWidth: 4)
                        }
                        .shadow(radius: 7)
                    
                    Text("Imran Hajiyev")
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
    }
}
