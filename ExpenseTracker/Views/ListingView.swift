//
//  ListingView.swift
//  ExpenseTracker
//
//  Created by Arthur Zhang on 2024-06-30.
//

import SwiftUI

struct ListingView: View {
    @StateObject var viewModel = ListingViewModel()
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    var body: some View {
        NavigationView {
            List {
//                ForEach(company.departments) { department in
//                    Section(header: Text(department.name)) {
//                        ForEach(department.staff) { person in
//                            NavigationLink(destination: PersonDetailView(person: person)) {
//                                PersonRowView(person: person)
//                            }
//                        }
//                    }
//                }
            }
            .navigationTitle("Transactions")
            .toolbar{
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView)
            {
                AddOrEditTransactionView( showingNewItemView: $viewModel.showingNewItemView).environmentObject(DataSingleton.instance)
            }


            // Placeholder
            Text("No Selection")
                .font(.headline)
        }
    }
}

#Preview {
    ListingView(userId: "")
}
