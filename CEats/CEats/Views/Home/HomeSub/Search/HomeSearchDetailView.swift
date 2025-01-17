//
//  HomeSearchDetailView.swift
//  CEats
//
//  Created by 유하은 on 2023/09/05.
//

import SwiftUI

struct HomeSearchDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var restaurantViewModel: RestaurantViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @FocusState private var isFocused: Bool
    @State var searchText: String = ""
    @State var isSubmit: Bool = false
    var array: Set<String> {
        Set(restaurantViewModel.collectAllFoodNames())
    }
    var body: some View {
        NavigationStack{
            VStack{
                ZStack{
                    Rectangle()
                        .frame(width: 350,height: 45)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .shadow(radius: 2)
                    ZStack{
                        HStack{
                            Image(systemName: "magnifyingglass")
                            TextField("\(userViewModel.user.username)님, 서브웨이 어때요?", text: $searchText)
                                .focused($isFocused)
                                .onSubmit{
                                    isSubmit.toggle()
                                }
                                .onAppear {
                                    isFocused = true
                                }
                            if !searchText.isEmpty {
                                Button(action: {
                                    self.searchText = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                }
                            } else {
                                EmptyView()
                            }
                        }
                        .padding(.leading,40)
                    }
                }
                
                Spacer()
                List {
                    ForEach(array.filter{$0.hasPrefix(searchText) || searchText == ""}, id:\.self) {
                        searchText in
                        NavigationLink {
                            AfterSearchView(data: searchText)
                        } label: {
                            Text(searchText)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .onAppear {
            if isFocused == false {
                hideKeyboard()
            }
        }
        .sheet(isPresented: $isSubmit) {
            AfterSearchView(data: searchText)
        }
    }
}

struct HomeSearchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSearchDetailView()
            .environmentObject(RestaurantViewModel())
            .environmentObject(UserViewModel())
    }
}
