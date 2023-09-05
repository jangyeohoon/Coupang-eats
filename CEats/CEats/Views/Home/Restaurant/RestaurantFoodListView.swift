//
//  RestaurantFoodListView.swift
//  CEats
//
//  Created by gnksbm on 2023/09/05.
//

import SwiftUI

struct RestaurantFoodListView: View {
    @Binding var restaurant: Restaurant
    
    var body: some View {
        ForEach(restaurant.foodCategory, id: \.self) { category in
            VStack(alignment: .leading) {
                Text(category)
                    .font(.system(size: 26, weight: .medium))
                Text("메뉴 사진은 연출된 이미지로 실제 조리된 음식과 다를 수 있습니다.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
                ForEach($restaurant.menus, id: \.name) { $food in
                    RestaurantFoodCellView(food: $food)
                    Divider()
                }
            }
            .padding(.horizontal)
        }
    }
}

struct RestaurantFoodListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantFoodListView(restaurant: .constant(.sampleData))
    }
}