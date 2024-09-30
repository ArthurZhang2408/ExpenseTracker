//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Arthur Zhang on 2024-06-29.
//

import SwiftUI

struct WelcomeView: View {
    
    @State var showSignIn: Bool = false
    @State var showSignUp: Bool = false
    
    var body: some View {
        ZStack{
            Image("welcome_screen")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            VStack{
                
                Text("EXPENSE TRACKER")
                    .font(.customfont(.regular, fontSize: 30))
                    .foregroundColor(.white)
                    .padding(.top, .topInsets + 30)
                
                Spacer()
                Text("Congue malesuada in ac justo, a tristique\nleo massa. Arcu le leo urna risus.")
                    .multilineTextAlignment(.center)
                    .font(.customfont(.regular, fontSize: 14))
                    .padding(.horizontal, 20)
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
                
                PrimaryButton(title: "Get Started", onPressed: {
                    showSignUp.toggle()
                })
                .background( NavigationLink(destination: SignupView(), isActive: $showSignUp, label: {EmptyView()}))
                .padding(.bottom, 15)
                
                SecondaryButton(title: "I have an account", onPressed: {
                    showSignIn.toggle()
                })
                .background( NavigationLink(destination: LoginView(), isActive: $showSignIn, label: {EmptyView()}))
                .padding(.bottom, .bottomInsets)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    WelcomeView()
}
