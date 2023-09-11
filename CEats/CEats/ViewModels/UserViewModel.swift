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
    
    func recommendFoods(food: [Restaurant.Food], restaurant: Restaurant ) -> [Restaurant.Food] {
        var menus = restaurant.menus
        
        if menus.count < 3 {
            return restaurant.menus
        }
        
        for selectedFood in food {
            menus.removeAll { $0.name == selectedFood.name }
        }
        
        return menus
    }
    
    func addCount(food: Restaurant.Food){
        if let index = self.user.foodCart?.cart.firstIndex(where: { $0.name == food.name }) {
            self.user.foodCart?.cart[index].foodCount += 1
        }
    }
    
    func subtractCount(food: Restaurant.Food){
        if let index = self.user.foodCart?.cart.firstIndex(where: { $0.name == food.name }) {
            self.user.foodCart?.cart[index].foodCount -= 1
        }
    }
    
    var filteredOrderList: [Order] {
        if selectedButton == .과거주문내역 {
            return user.orderHistory.filter { $0.orderStatus != .waiting }
        } else {
            return user.orderHistory.filter { $0.orderStatus == .waiting }
        }
    }
    
    func updateUserLocation(user: User, lat: Double, long: Double, adress: String) {
        fireManager.update(data: user, value: \.latitude, to: lat) { result in
            self.user = result
        }
        fireManager.update(data: user, value: \.longitude, to: long) { result in
            self.user = result
        }
        fireManager.update(data: user, value: \.userAddress, to: adress) { result in
            self.user = result
        }
    }
    
    func updateUserCart(restaurant: Restaurant, food: Restaurant.Food) {
        user.foodCart?.cart.append(food)
        fireManager.create(data: user)
    }
    
    func updateUserOrder(user: User, order: [Order]){
        fireManager.update(data: user, value: \.orderHistory, to: order) { result in
            self.user = result
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
