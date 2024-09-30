//
//  CategoryModel.swift
//  ExpenseTracker
//
//  Created by Arthur Zhang on 2024-07-01.
//

import SwiftUI

struct CategoryModel: View {
    var cObj: ExpenseCategory = ExpenseCategory(name: "Grocery", img: "🥬", spent: 400000, subCategories: [])
    var clicked: Bool = false
//    BudgetModel(dict: [ "name": "Auto & Transport",
//                                                       "icon": "auto_&_transport",
//                                                       "spend_amount": 25.99,
//                                                       "total_amount": 400,
//                                                       "color": Color.secondaryG ] )
    var body: some View {
        
        VStack{
            HStack{
                
                Text(cObj.img)
                    .font(.customfont(.semibold, fontSize: 25))
                    .frame(width: 35, height: 20)
                    .foregroundColor(.white)
                
                VStack{
                    Text(cObj.name)
                        .font(.customfont(.semibold, fontSize: 14))
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: 100, alignment: .leading)
                }
                
                VStack(alignment: .trailing){
                    Text("This Month Spent $\(cObj.spent.formatted())")
                        .font(.customfont(.semibold, fontSize: 14))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                }
            }
//            ProgressView(value: bObj.perSpend, total: 1)
//                .tint(bObj.color)
        }
        
        .padding(15)
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.gray60.opacity( 0.2  ))
        .overlay {
            RoundedRectangle(cornerRadius:  12)
                .stroke(  Color.gray70, lineWidth: 1)
        }
        .cornerRadius(12)
    }
}

#Preview {
    CategoryModel()
}
