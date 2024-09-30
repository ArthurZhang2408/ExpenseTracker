//
//  SignupView.swift
//  ExpenseTracker
//
//  Created by Arthur Zhang on 2024-06-30.
//

import SwiftUI

struct SignupView: View {
    
    @StateObject var viewModel = SignupViewModel()
    
    var body: some View {
        ZStack{
                        
            VStack{
                
                Text("EXPENSE TRACKER")
                    .font(.customfont(.regular, fontSize: 30))
                    .foregroundColor(.white)
                    .padding(.top, .topInsets + 20)
                Text("SIGN UP")
                    .font(.customfont(.regular, fontSize: 20))
                    .foregroundColor(.white)
                    .padding(.top, 5)
                
                
                Spacer()
                
//                if !viewModel.errorMessage.isEmpty {
//                    Text(viewModel.errorMessage)
//                        .multilineTextAlignment(.leading)
//                        .font(.customfont(.regular, fontSize: 14))
//                        .frame(minWidth: 0, maxWidth: .screenWidth, alignment: .leading)
//                        .foregroundColor(.red)
//                    
//                        .padding(.horizontal, 20)
//                        .padding(.bottom, 15)
//                }
                
                RoundTextField(title: "Full Name", text: $viewModel.txtName, keyboardType: .disableAuto)

                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                
                RoundTextField(title: "E-mail Address", text: $viewModel.txtEmail, keyboardType: .email)

                .padding(.horizontal, 20)
                .padding(.bottom, 15)

                RoundTextField(title: "Passowrd", text: $viewModel.txtPassword, keyboardType: .password)

                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                RoundTextField(title: "Re-enter Passowrd", text: $viewModel.txtPasswordReenter, keyboardType: .password)

                .padding(.horizontal, 20)
                .padding(.bottom, 25)
//
//                HStack {
//                    
//                    Rectangle()
//                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 5, maxHeight: 5)
//                        .padding(.horizontal, 1)
//                    
//                    Rectangle()
//                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 5, maxHeight: 5)
//                        .padding(.horizontal, 1)
//                    
//                    Rectangle()
//                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 5, maxHeight: 5)
//                        .padding(.horizontal, 1)
//                    
//                    Rectangle()
//                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 5, maxHeight: 5)
//                        .padding(.horizontal, 1)
//                    
//                }
//                .padding(.horizontal, 20)
//                .foregroundColor(.gray70)
//                .padding(.bottom, 20)
//                
//                Text("Use 8 or more characters with a mix of letters,\nnumbers & symbols.")
//                    .multilineTextAlignment(.leading)
//                    .font(.customfont(.regular, fontSize: 14))
//                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                    .padding(.horizontal, 20)
//                    .foregroundColor(.gray50)
//                    .padding(.bottom, 20)
                
                PrimaryButton(title: "Get Started, it's free!", onPressed: {
                    viewModel.signin()
                })
                
                Spacer()
                
                Text("Do you have already an account?")
                    .multilineTextAlignment(.center)
                    .font(.customfont(.regular, fontSize: 14))
                    .padding(.horizontal, 20)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                SecondaryButton(title: "Sign In", onPressed: {
                    viewModel.showSignIn.toggle()
                })
                .background( NavigationLink(destination: LoginView(), isActive: $viewModel.showSignIn, label: {
                    EmptyView()
                }) )
                .padding(.bottom, .bottomInsets + 8)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        .background(Color.grayC)
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage)
            )
        }
    }
}

#Preview {
    SignupView()
}
