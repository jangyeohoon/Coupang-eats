//
//  RTRFoodCellView.swift
//  CEats
//
//  Created by gnksbm on 2023/09/05.
//

import SwiftUI

struct RTRFoodCellView: View {
    let food: Food
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(food.name)")
                    .font(.system(size: 18, weight: .bold))
                Text("\(food.priceToString)원")
                    .font(.system(size: 16))
                Text("\(food.description)")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    .padding(.vertical, 5)
            }
            Spacer()
            Image(food.image ?? "")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130, height: 130)
        }
    }
}

struct RTRFoodCellView_Previews: PreviewProvider {
    static var previews: some View {
        RTRFoodCellView(food: .sampleData)
    }
}
