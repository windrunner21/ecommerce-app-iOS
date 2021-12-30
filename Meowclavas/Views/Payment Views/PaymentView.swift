//
//  PaymentView.swift
//  Meowclavas
//
//  Created by Imran on 22.12.21.
//

import SwiftUI

struct PaymentView: View {
    @State private var step2Active = false
    @State private var step3Active = false
    
    var stepper: Stepper {
        var result: Stepper = Stepper(count: 1, title: "Shipping")
        
        if !step2Active && !step3Active {
            result = Stepper(count: 1, title: "Shipping")
        }
        
        if step2Active {
            result = Stepper(count: 2, title: "Payment")
        }
        
        if step3Active {
            result = Stepper(count: 3, title: "")
        }
        
        return result
    }
    
    var body: some View {
        VStack {
            // progress view for the payment
            StepIndicatorView(
                step2Active: $step2Active,
                step3Active: $step3Active
            )
            
            // stepper title and count
            VStack {
                HStack {
                    Text("Step \(stepper.count)")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                }
                
                HStack {
                    Text(stepper.title)
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                }
            }
            .padding()
            
            if !step2Active && !step3Active {
                ShippingView(step2Active: $step2Active)
            }
            
            if step2Active && !step3Active{
                PayView(step3Active: $step3Active)
            }
            
            if step3Active {
                CongratsView()
                
                
            }


            Spacer()
        }
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}
