//
//  MyPageRestaurantView.swift
//  CEats
//
//  Created by 박범수 on 2023/09/11.
//

import SwiftUI

struct MyPageRestaurantView: View {
    let restaurant: Restaurant
    @State private var selectedIndex = 0
    
    var body: some View {
        VStack {
            HStack {
                TabView(selection: $selectedIndex) {
                    ForEach(restaurant.mainImage, id: \.self) { image in
                        Image(image)
                            .resizable()
                            .scaledToFill()
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(maxWidth: .screenWidth * 0.3, minHeight: .screenHeight * 0.1)
                .cornerRadius(10)
                .padding()
                VStack(alignment: .leading, spacing: 8) {
                    Text(restaurant.name)
                        .bold()
                    HStack(spacing: 0) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(restaurant.scoreMessage)(\(restaurant.reviews.count))")
                    }
                    Text("\(restaurant.deliveryTime) · \(restaurant.deliveryFee)")
                }
                .foregroundColor(.primary)
                Spacer()
            }
            Divider()
                .padding(.horizontal, 15)
        }
        .padding(.horizontal)

    }
}

struct MyPageRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageRestaurantView(restaurant: .sampleData)
    }
}
