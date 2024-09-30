//
//  NewCategoryView.swift
//  ExpenseTracker
//
//  Created by Arthur Zhang on 2024-06-30.
//

import SwiftUI

struct AddOrEditCategoryView: View {
    
    @StateObject var viewModel = AddOrEditCategoryViewModel(editing: "")
    @Binding var showingNewCategoryView: Bool
    @EnvironmentObject var instance: DataSingleton
    
    var body: some View {
        ZStack{
                        
            VStack{
                
                Text("EXPENSE TRACKER")
                    .font(.customfont(.regular, fontSize: 30))
                    .foregroundColor(.white)
                    .padding(.top, .topInsets + 20)
                Text("\(viewModel.title) CATEGORY")
                    .font(.customfont(.regular, fontSize: 20))
                    .foregroundColor(.white)
                    .padding(.top, 5)
                
                ScrollViewReader { value in
                    ScrollView {
                        
//                        if !viewModel.errorMessage.isEmpty {
//                            Text(viewModel.errorMessage)
//                                .multilineTextAlignment(.leading)
//                                .font(.customfont(.regular, fontSize: 14))
//                                .frame(minWidth: 0, maxWidth: .screenWidth, alignment: .leading)
//                                .foregroundColor(.red)
//                            
//                                .padding(.horizontal, 20)
//                                .padding(.top, 25)
//                        }
                        
                        HStack {
                            RoundTextField(title: "Name", text: $viewModel.category)
                            
                                .padding(.leading, 20)
                            RoundTextField(title: "Icon", text: $viewModel.icon, keyboardType: .emoji, charLimit: 1)
                                .frame(width: 50)
                                .padding(.trailing, 20)
                            
                        }
                        .padding(.top, 15)
                        
                        VStack(alignment: .trailing) {
                            ForEach(0..<viewModel.subCategories.count, id: \.self) {index in
                                //                        Text(self.listArr[$0])
                                HStack {
                                    if (index == 0) {
                                        RoundTextField(title: "Subcategories", text: $viewModel.subCategories[index])
                                            .padding(.horizontal, 20)
                                        Text("")
                                            .frame(width: 30, height: 30)
                                            .padding(.trailing, 20)
                                    } else {
                                        RoundTextField(title: "", text: $viewModel.subCategories[index])
                                            .padding(.horizontal, 20)
                                        VStack (){
                                            
                                            Text("")
                                                .multilineTextAlignment(.leading)
                                                .font(.customfont(.regular, fontSize: 14))
                                                .padding(.bottom, 4)
                                            Button {
                                                viewModel.removeSubCategory(index: index)
                                            } label: {
                                                Image(systemName: "minus.circle")
                                                    .resizable()
                                                    .frame(width: 30, height: 30)
                                                    .frame(alignment: .bottomTrailing)
                                                    .padding(.trailing, 20)
                                            }
                                            
                                        }
                                    }
                                }
                            }
                            Button {
                                viewModel.addSubCategory()
                                withAnimation {
                                    value.scrollTo("spacer")
                                }
                            } label: {
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(.top, 20)
                                    .frame(alignment: .trailing)
                                    .padding(.trailing, 20)
                            }
                        }
                        .padding(.top, 30)
                        .padding(.bottom, 300)
                        Spacer().id("spacer")
                    }
                }
            
                
                PrimaryButton(title: "Save", onPressed: {
                    
                    if viewModel.save() {
                        showingNewCategoryView = false
                    }
                }).padding(.bottom, .bottomInsets + 8)
            }
            .scrollDismissesKeyboard(.immediately)
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
    AddOrEditCategoryView(showingNewCategoryView: Binding(get: {return true}, set: { _ in}))
}

