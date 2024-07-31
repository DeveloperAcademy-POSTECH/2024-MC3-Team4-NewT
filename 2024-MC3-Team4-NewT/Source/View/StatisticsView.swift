//
//  StatisticsView.swift
//  2024-MC3-Team4-NewT
//
//  Created by 김이예은 on 7/31/24.
//

import SwiftUI

struct StatisticsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing:0){
            HStack(alignment: .center) {
                Text("내가 선호하는 맞춤 수치")
                    .font(.Heading3Bold)
                    .foregroundColor(.white)
                Spacer()
                Button {
                    print("자세히 보기")
                } label: {
                    Image("infoIcon")
                    //                    HStack(alignment: .center, spacing: 2){
                    //                        Text("자세히 보기").font(.Body2SemiBold)
                    //                        Image(systemName: "chevron.right")
                    //                    }.foregroundColor(.white)
                }
            }.padding(.bottom, 24)
            
            HStack(spacing:0){
                ZStack{
                    VStack(alignment: .leading, spacing:0){
                        HStack{
                            Image("windFillIcon")
                                .foregroundColor(Color("surfBlue"))
                            
                            Text("바람")
                                .font(.Body1Bold)
                            .foregroundColor(Color("surfBlue"))                                }
                        Spacer()
                        HStack(alignment: .center, spacing:0){
                            Text("0.2m")
                                .font(.Heading1SemiBold)
                                .foregroundColor(Color("surfBlue"))
                            Spacer()
                            Image("waveDirectionIcon2")
                                .foregroundColor(Color("surfBlue"))
                                .padding(4)
                        }
                    }.padding(12)
                        .frame(minHeight: 139)
                }
                .background(.white.opacity(0.5))
                .cornerRadius(24)
                Spacer()
                    .frame(width: 13)
                ZStack{
                    VStack(alignment: .leading, spacing:0){
                        HStack{
                            Image("waveFillIcon")
                                .foregroundColor(Color("surfBlue"))
                            
                            Text("파도")
                                .font(.Body1Bold)
                                .foregroundColor(Color("surfBlue"))
                            Spacer()
                        }
                        .padding(.bottom, 9)
                        Spacer()
                        HStack(alignment: .bottom) {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("0.2m")
                                    .font(.Heading1SemiBold)
                                    .foregroundColor(Color("surfBlue"))
                                Text("3.3m/s")
                                    .font(.SubheadingSemiBold)
                                    .foregroundColor(Color("surfBlue"))
                            }
                            Spacer()
                            Image("swellDirectionIcon2")
                                .foregroundColor(Color("surfBlue"))
                                .padding(4)
                        }
                        
                    }.padding(12)
                        .frame(minHeight: 139)
                }
                .background(.white.opacity(0.5))
                .cornerRadius(24)
            }
            .padding(.top)
            .padding(.bottom, 25)
            Spacer()
        }
        .frame(height: 202)
        
    }
}

#Preview {
    StatisticsView()
}
