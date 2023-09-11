//
//  UserViewModel.swift
//  CEats
//
//  Created by 박범수 on 2023/09/07.
//

import Foundation

final class UserViewModel: ObservableObject {
    @Published var user: User = User.sampleData
    @Published var selectedButton: OrderState = .과거주문내역
    
    let fireManager = CEatsFBManager.shared
    
    enum OrderState: String, CaseIterable {
        case 과거주문내역
        case 준비중
    }
    
    var filteredOrderList: [Order] {
        if selectedButton == .과거주문내역 {
            return user.orderHistory.filter { $0.orderStatus != .waiting }
        } else {
            return user.orderHistory.filter { $0.orderStatus == .waiting }
        }
    }
    
    func getLikeImageName(restaurant: Restaurant) -> String {
        return user.favoriteRestaurant.contains(where: { $0.id == restaurant.id }) ? "heart.fill" : "heart"
    }
    
    func likeButtonTapped(restaurant: Restaurant) {
        let isLiked = user.favoriteRestaurant.contains(where: { $0.id == restaurant.id })
        if isLiked {
            guard let index = user.favoriteRestaurant.firstIndex(where: { $0.id == restaurant.id }) else { return }
            user.favoriteRestaurant.remove(at: index)
        } else {
            user.favoriteRestaurant.append(restaurant)
        }
    }
}