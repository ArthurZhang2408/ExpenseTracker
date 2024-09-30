//
//  ListingView.swift
//  ExpenseTracker
//
//  Created by Arthur Zhang on 2024-06-30.
//


import FirebaseFirestoreSwift
import SwiftUI

struct ListingView: View {
    @StateObject var viewModel = ListingViewModel()
    @FirestoreQuery var items: [ExpenseTransaction]
    
    init(userId: String) {
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/transactions")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in
                    Text(item.amount.description)
                }
                .listStyle(.plain)
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
    ListingView(userId: "Za54qIrdRufeXzJ5xcTniwXWWQI2")
}
