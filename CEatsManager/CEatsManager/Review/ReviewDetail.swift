//
//  ReviewDetail.swift
//  CEatsManager
//
//  Created by 박범수 on 2023/09/12.


import SwiftUI
import MapKit


struct ReviewDetail: View {
    // MARK: - Properties
    @EnvironmentObject var restaurantViewModel: RestaurantViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var place = ""
    var restaurant: Restaurant
    
    // MARK: - Views
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("가게 전화번호 : \(restaurant.restaurantInfo.phoneNumberString)")
                            .font(.system(size: 20))
                            .bold()
                    }
                    .padding([.leading, .bottom], 20)
                    Divider()
                    
                    ForEach(restaurant.reviews) { review in
                        ReviewInfo(review: review, restaurant: restaurant)
                    }
                }
                .navigationTitle("\(restaurant.name)")
            }
        }
    }
    func convertLocationToAddress(location: CLLocation) {
        
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if error != nil {
                print("ERROR!!")
                return
            }
            
            guard let placemark = placemarks?.first else { return }
            
            place = "\(placemark.locality ?? "") \(placemark.name ?? "")"
            
            print("장소:\(place)")
        }
    }
}

struct ReviewDetail_Previews: PreviewProvider {
    static var previews: some View {
        ReviewDetail(restaurant: Restaurant.sampleArray[0])
            .environmentObject(RestaurantViewModel())
            .environmentObject(UserViewModel())
    }
}
