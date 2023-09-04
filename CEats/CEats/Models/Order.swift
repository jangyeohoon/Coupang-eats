//
//  Order.swift
//  CEats
//
//  Created by 박범수 on 2023/09/04.
//

import Foundation


struct Order: Identifiable {
    var id: String
    var orderer: User
    var restaurantName : Restaurant //
    var orderedMenu: [Food]
    var deliveryTime: Int
    var totalFee: Int
}
