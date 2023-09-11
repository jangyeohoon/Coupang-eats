//
//  ReciptView.swift
//  CEats
//
//  Created by 유하은 on 2023/09/11.
//

import SwiftUI

struct ReciptView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .center){
            ForEach(userViewModel.filteredOrderList) { order in
                    VStack{
                        Text(order.restaurantName.name)
                            .font(.system(size:22))
                            .bold()
                            .padding(.bottom,10)
                        HStack{
                            Text("주문번호:")
                                .foregroundColor(.black)
                            Text(order.id.prefix(5))
                                .font(.system(size:15))
                        }
                        //배달시간
                    }.padding(.bottom,10)

                ForEach(order.orderedMenu, id: \.name) { food in
                    HStack{
                        Text(food.name)
                            .font(.system(size:16))
                        Spacer()
                        Text(food.priceToString)
                    }
                }
                Divider()
                    .padding(20)
                
                .foregroundColor(.gray)
                HStack{
                    Text("배달비:")
                    Spacer()
                    Text("\(order.restaurantName.deliveryFee)원")
                }
                HStack{
                    Text("주문금액:")
                    Spacer()
                    Text("\(order.totalFee)원")
                }
                
                Divider()
                    .padding(20)
                
                HStack{
                    Text("최초 결제금액:")
                    Spacer()
                    Text("\(order.totalFee)원")
                }
                HStack{
                    Text(("C-Eats Money 결제"))
                    Spacer()
                    Text("\(order.totalFee)원")
                }
                .font(.system(size: 13))
                .foregroundColor(.secondary)
                
            }
            Divider()
                .padding(20)
            Text("(배달 주소)\(userViewModel.user.userAddress)")
            
        }
        .navigationTitle("영수증")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }
        }
    }
}

struct ReciptView_Previews: PreviewProvider {
    static var previews: some View {
        ReciptView()
            .environmentObject(UserViewModel())
    }
}
