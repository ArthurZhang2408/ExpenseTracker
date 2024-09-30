//
//  AddOrEditTransactionView.swift
//  ExpenseTracker
//
//  Created by Arthur Zhang on 2024-07-07.
//

import SwiftUI

struct AddOrEditTransactionView: View {
    
    @StateObject var viewModel = AddOrEditTransactionViewModel(id: "")
    @Binding var showingNewItemView: Bool
    @EnvironmentObject var envObj: DataSingleton
    
    var body: some View {
        ZStack{
                        
            VStack{
                
                Text("EXPENSE TRACKER")
                    .font(.customfont(.regular, fontSize: 30))
                    .foregroundColor(.white)
                    .padding(.top, .topInsets + 20)
                Text("\(viewModel.title) TRANSACTION")
                    .font(.customfont(.regular, fontSize: 20))
                    .foregroundColor(.white)
                    .padding(.top, 5)
                
                
                Spacer()
                
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
                            RoundTextField(title: "Amount", text: $viewModel.amount, keyboardType: .decimal)
                            
                                .padding(.leading, 20)
                            VStack(alignment: .trailing) {
                                Text("Currency")
                                    .multilineTextAlignment(.trailing)
                                    .font(.customfont(.regular, fontSize: 14))
                                    .foregroundColor(.gray50)
                                    .padding(.bottom, 4)
                                    .frame(alignment: .trailing)
                                VStack{
                                    Picker(selection: $viewModel.currency) {
                                        ForEach(Currency.allCases) { curr in
                                            Text(curr.rawValue)
                                        }
                                    } label: {
                                    }
                                }.frame(height: 48)
                            }
                            .padding(.trailing, 20)
                        }
                        .padding(.top, 30)
                        .padding(.bottom, 20)
                        
                        DatePicker("Created", selection: $viewModel.createdDate).datePickerStyle(DefaultDatePickerStyle())
                        
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)
                            .font(.customfont(.regular, fontSize: 14))
                            
                            .foregroundColor(.gray50)
                        
                        Text("Categories")
                            .multilineTextAlignment(.leading)
                            .font(.customfont(.regular, fontSize: 14))
                            .frame(minWidth: 0, maxWidth: .screenWidth, alignment: .leading)
                            
                            .foregroundColor(.gray50)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 4)
                        LazyVStack(spacing: 15) {
                            ForEach(0..<viewModel.instance.models.count, id: \.self) {index in
                                //                        Text(self.listArr[$0])
                                Button {
                                    viewModel.click(index: index)
                                    print(index)
                                } label: {
                                    viewModel.instance.models[index]
                                }
                                if (viewModel.instance.models[index].clicked) {
                                    ForEach(viewModel.instance.models[index].cObj.subCategories, id: \.self) {sub in
                                        
                                        Button {
                                            viewModel.select(sub: sub, catInd: index)
                                        } label: {
                                            Text(sub)
                                                .font(.customfont(.semibold, fontSize: 14))
                                                .foregroundColor( .white )
                                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 36, maxHeight: 36)
                                                .background(Color.gray60.opacity( sub==viewModel.subCategory ? 0.4:0))
                                                
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 9)
                                                        .stroke(  Color.gray70, lineWidth: 1)
                                                }
                                                .cornerRadius(9)
                                                .padding(.horizontal, 20)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        Button (action: {
                            viewModel.showingNewCategoryView = true
                        }) {
                            
                            HStack{
                                Text("Add new category ")
                                    .font(.customfont(.semibold, fontSize: 14))
                                
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .frame(width: 14, height: 14)
                            }
                            .foregroundColor( .gray30 )
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                            
                            
                            .overlay {
                                RoundedRectangle(cornerRadius:  12)
                                    .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5,4]) )
                                    .foregroundColor(.gray30.opacity(0.5))
                            }
                            .cornerRadius(12)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .padding(.bottom, 40)
                        }
                        .sheet(isPresented: $viewModel.showingNewCategoryView)
                        {
                            AddOrEditCategoryView(showingNewCategoryView: $viewModel.showingNewCategoryView).environmentObject(DataSingleton.instance)
                        }
                            
                        
                        Spacer()
                    }
                }
                
                
                PrimaryButton(title: "Save", onPressed: {
                    if viewModel.save() {
                        showingNewItemView = false
                    }
                })
                .padding(.bottom, .bottomInsets + 8)
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
    AddOrEditTransactionView(showingNewItemView: Binding(get: {return true}, set: { _ in}))
}
