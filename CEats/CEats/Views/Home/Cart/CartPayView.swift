//
//  CartPayView.swift
//  CEats
//
//  Created by 박범수 on 2023/09/07.
//

import SwiftUI

struct CartPayView: View {
    // MARK: - Properties
    @EnvironmentObject private var userViewModel : UserViewModel
    @State private var isappeal: Bool = true
    @State private var ispayment: Bool = true
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                HStack {
                    Text("주문금액")
                        .padding(.leading)
                    Spacer()
                    Text("\(userViewModel.cartFee)원")
                        .padding(.trailing)
                }
                HStack {
                    Text("배달비")
                        .padding([.top, .leading, .bottom])
                    Spacer()
                    // 일반 값을 가져다 쓸 때는 $ 사인 없이 가져다 쓰는 것.
                    Text("\(userViewModel.deliveryOpt.fee)원")
                        .padding(.trailing)
                }
                Divider()
                HStack {
                    Text("총 결제금액")
                    Spacer()
                    Text("\(userViewModel.cartFee + userViewModel.deliveryOpt.fee)원")
                }
                .font(.title3)
                .bold()
                .padding()
                
                HStack {
                    Text("요청사항")
                        .font(.title3)
                        .bold()
                        .padding()
                    Spacer()
                    Button {
                        // 눌리면 꺾새 내려가게 해야함.
                        // CartappealView 가 보임.
                        
                        isappeal.toggle()
                    } label: {
                        Image(systemName: isappeal ? "chevron.down" : "control")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(.black)
                            .frame(width: 20, height: 10)
                            .padding(.trailing)
                    }
                }
                Divider()
                if isappeal {
                    CartAppealView()
                }
                HStack {
                    Text("결제수단")
                        .font(.title3)
                        .bold()
                        .padding()
                    Spacer()
                    Button {
                        ispayment.toggle()
                    } label: {
                        Image(systemName: ispayment ? "chevron.down" : "control")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(.black)
                            .frame(width: 20, height: 10)
                            .padding(.trailing)
                    }
                }
                Divider()
                // isPayment가 토글이 되면 CartPaymentView() 가 요청사항과 같이 내려오게 됨.
                // Extra argument in call 오류가 떴었음. divider를 남발해서 화면 프레임에서 벗어났기 때문이였습니다.
                if ispayment {
                    CartPaymentView()
                }
            }
        }
    }
}

struct CartPayView_Previews: PreviewProvider {
    static var previews: some View {
        CartPayView()
            .environmentObject(UserViewModel())
    }
}
