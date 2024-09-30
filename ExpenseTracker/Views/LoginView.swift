//
//  LoginView.swift
//  ExpenseTracker
//
//  Created by Arthur Zhang on 2024-06-30.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack{
                        
            VStack{
                
                Text("EXPENSE TRACKER")
                    .font(.customfont(.regular, fontSize: 30))
                    .foregroundColor(.white)
                    .padding(.top, .topInsets + 20)
                Text("LOG IN")
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
                
                RoundTextField(title: "E-mail", text: $viewModel.txtEmail, keyboardType: .email)
                
                .padding(.horizontal, 20)
                .padding(.bottom, 15)
                
                
                
                RoundTextField(title: "Password", text: $viewModel.txtPassword, keyboardType: .password)
                
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                
                
//                HStack{
//                    Button {
//                        isRemember = !isRemember
//                    } label: {
//                        
//                        HStack{
//                            
//                            Image(systemName: isRemember ? "checkmark.square" : "square")
//                                .resizable()
//                                .frame(width: 20, height: 20)
//                            
//                            Text("Forgot Password")
//                                .multilineTextAlignment(.center)
//                                .font(.customfont(.regular, fontSize: 14))
//                        }
//                        
//                        
//                            
//                    }
//                    .foregroundColor(.gray50)
//                    
//                    Spacer()
//                    Button {
//                        
//                    } label: {
//                        Text("Forgot Password")
//                            .multilineTextAlignment(.center)
//                            .font(.customfont(.regular, fontSize: 14))
//                            
//                    }
//                    .foregroundColor(.gray50)
//
//                }
//                .padding(.horizontal, 20)
//                .padding(.bottom, 15)
                
                PrimaryButton(title: "Sign In", onPressed: {
                    
                    viewModel.login()
                })
                
                Spacer()
                
                Text("if you don't have an account yet?")
                    .multilineTextAlignment(.center)
                    .font(.customfont(.regular, fontSize: 14))
                    .padding(.horizontal, 20)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                SecondaryButton(title: "Sign Up", onPressed: {
                    viewModel.showSignUp.toggle()
                })
                .background( NavigationLink(destination: SignupView(), isActive: $viewModel.showSignUp, label: {
                    EmptyView() 
                }) )
                .padding(.bottom, .bottomInsets + 8)
            }
        }
        .navigationTitle("Log In")
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
    LoginView()
}
