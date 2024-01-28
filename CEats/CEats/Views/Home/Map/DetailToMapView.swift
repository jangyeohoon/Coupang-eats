//
//  DetailToMapView.swift
//  CEats
//
//  Created by 변상우 on 2023/09/06.
//

import SwiftUI
import MapKit

struct DetailToMapView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var userViewModel: UserViewModel
    
    @Binding var isOpenMapSheet: Bool
    @Binding var isSelectedPlace: String
    @Binding var selectedPlaceLat: Double
    @Binding var selectedPlaceLong: Double
    
    @State private var isChangingPlace: Bool = false
    @State private var showMessage = true
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5718, longitude: 126.9769), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    @State private var place: String = ""
    
    var lat: Double {
        region.center.latitude
    }
    
    var long: Double {
        region.center.longitude
    }
    
    var body: some View {
        VStack {
            ZStack{
                Map(coordinateRegion: $region, userTrackingMode: .constant(.follow), annotationItems: [Annotation(coordinate: CLLocationCoordinate2D(latitude: 37.5718, longitude: 126.9769))]) { locaiton in
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: region.center.latitude, longitude: region.center.longitude))
                }
                if showMessage {
                    MapGuide()
                        .offset(y:-(.screenHeight/3.5))
                }
            }
            //MapViewCoordinator(locationManager: locationManager)
            Text("\(place)")
                .padding()
            
            Button {
                isSelectedPlace = place
                selectedPlaceLat = lat
                selectedPlaceLong = long
                print("\(place)")
                print("\(lat)")
                print("\(long)")
                
                
                print("=======맵뷰 닫음======")
                print("\(isSelectedPlace)")
                print("\(selectedPlaceLat)")
                print("\(selectedPlaceLong)")
                print("=======맵뷰 닫음======")
                
                dismiss()
                
                
            } label: {
                Text("설정하기")
                    .foregroundColor(.white)
                    .padding(.horizontal, 100)
                    .padding(.vertical, 10)
                    .frame(width: .screenWidth * 0.8, height: 50)
                    .background(Color.blue)
            }
            .padding(.bottom)
        }
        .navigationTitle("주소 설정")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        
        .onAppear {
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: selectedPlaceLat, longitude: selectedPlaceLong), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        }
        
        .onChange(of: region) { newValue in
            if !isChangingPlace {
                isChangingPlace = true
                convertLocationToAddress(location: CLLocation(latitude: region.center.latitude, longitude: region.center.longitude))
            } else {
                print("LOCK!")
            }
        }
        .onTapGesture(perform: {
            showMessage = false //사용자가 터치하는 순간 바꾸고 싶음..
        })
        .task {
            showMessage = true
        }
    }
    
    func convertLocationToAddress(location: CLLocation) {
        
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if error != nil {
                self.isChangingPlace = false
                print("ERROR!!")
                return
            }
            
            guard let placemark = placemarks?.first else { return }
            
            place = "\(placemark.locality ?? "") \(placemark.name ?? "")"
            
            print("위도:\(lat) 경도:\(long) 장소:\(place)")
            self.isChangingPlace = false
        }
        
    }
    
    var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "arrow.left")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.black)
        }
    }
}

struct DetailToMapView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailToMapView(isOpenMapSheet: .constant(true), isSelectedPlace: .constant(""), selectedPlaceLat: .constant(0), selectedPlaceLong: .constant(0))
        }
    }
}
