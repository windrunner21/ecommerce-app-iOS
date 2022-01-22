//
//  LottieView.swift
//  Meowclavas
//
//  Created by Imran on 22.01.22.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var name: String
    var loopMode: LottieLoopMode
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = AnimationView()
        
        // load animation file
        let animation = Animation.named(name)
        animationView.animation = animation
        
        // set scaling and looping
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        
        // play animation
        animationView.play()
        
        // constraints
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
    }
}
