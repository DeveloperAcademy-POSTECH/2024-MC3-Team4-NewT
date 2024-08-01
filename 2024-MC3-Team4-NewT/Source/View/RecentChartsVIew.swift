//
//  RecentChartsVIew.swift
//  2024-MC3-Team4-NewT
//
//  Created by 김이예은 on 7/31/24.
//

import SwiftUI

struct RecentChartsVIew: View {
    var body: some View {
        VStack(spacing: 0){
            HStack{
                Text("최근 기록 차트")
                    .font(.Heading3Bold)
                    .foregroundColor(.white)
                Spacer()
                Button{
                    
                } label: {
                    Text("자세히 보기")
                        .font(.Body2SemiBold)
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom, 12)
            
            ZStack{
                Color.white.opacity(0.8)
                    .frame(height: 50)
                HStack(spacing: 20){
                    VStack(spacing: 0){
                        Text("7/26")
                            .font(.Body2Bold)
                            .foregroundColor(.surfBlue)
                        Text("03시")
                            .font(.CaptionMedium)
                            .foregroundColor(Color("surfBlue"))
                    }
                    HStack(spacing: 0){
                        Image(systemName: "paperplane")
                            .foregroundColor(Color("iconGreen"))
                        Text("3.3m/s")
                            .font(.Body2Medium)
                    }
                    HStack(spacing: 0){
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(Color("iconBlue"))
                        VStack(spacing: 0){
                            Text("0.2m")
                                .font(.Body2Medium)
                            Text("3.3m/s")
                                .font(.CaptionMedium)
                        }
                    }
                    VStack(spacing: 0){
                        Text("28°C")
                            .font(.Body2Medium)
                        Image(systemName: "water.waves")
                            .foregroundColor(Color("iconWaterOrange"))
                    }
                    HStack(spacing: 0){
                        Image(systemName: "star.fill")
                            .foregroundColor(Color("iconStarOrange"))
                        Text("5")
                            .font(.Body2SemiBold)
                    }
                }
            }
            .cornerRadius(24)
            .padding(.bottom, 4)
            
            ZStack{
                Color.white.opacity(0.8)
                    .frame(height: 50)
                HStack(spacing: 20){
                    VStack(spacing: 0){
                        Text("7/26")
                            .font(.Body2Bold)
                            .foregroundColor(.surfBlue)
                        Text("03시")
                            .font(.CaptionMedium)
                            .foregroundColor(Color("surfBlue"))
                    }
                    HStack(spacing: 0){
                        Image(systemName: "paperplane")
                            .foregroundColor(Color("iconGreen"))
                        Text("3.3m/s")
                            .font(.Body2Medium)
                    }
                    HStack(spacing: 0){
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(Color("iconBlue"))
                        VStack(spacing: 0){
                            Text("0.2m")
                                .font(.Body2Medium)
                            Text("3.3m/s")
                                .font(.CaptionMedium)
                        }
                    }
                    VStack(spacing: 0){
                        Text("28°C")
                            .font(.Body2Medium)
                        Image(systemName: "water.waves")
                            .foregroundColor(Color("iconWaterOrange"))
                    }
                    HStack(spacing: 0){
                        Image(systemName: "star.fill")
                            .foregroundColor(Color("iconStarOrange"))
                        Text("5")
                            .font(.Body2SemiBold)
                    }
                }
            }
            .cornerRadius(24)
            .padding(.bottom, 4)
            
            ZStack{
                Color.white.opacity(0.8)
                    .frame(height: 50)
                HStack(spacing: 20){
                    VStack(spacing: 0){
                        Text("7/26")
                            .font(.Body2Bold)
                            .foregroundColor(.surfBlue)
                        Text("03시")
                            .font(.CaptionMedium)
                            .foregroundColor(Color("surfBlue"))
                    }
                    HStack(spacing: 0){
                        Image(systemName: "paperplane")
                            .foregroundColor(Color("iconGreen"))
                        Text("3.3m/s")
                            .font(.Body2Medium)
                    }
                    HStack(spacing: 0){
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(Color("iconBlue"))
                        VStack(spacing: 0){
                            Text("0.2m")
                                .font(.Body2Medium)
                            Text("3.3m/s")
                                .font(.CaptionMedium)
                        }
                    }
                    VStack(spacing: 0){
                        Text("28°C")
                            .font(.Body2Medium)
                        Image(systemName: "water.waves")
                            .foregroundColor(Color("iconWaterOrange"))
                    }
                    HStack(spacing: 0){
                        Image(systemName: "star.fill")
                            .foregroundColor(Color("iconStarOrange"))
                        Text("5")
                            .font(.Body2SemiBold)
                    }
                }
            }
            .cornerRadius(24)
            .padding(.bottom, 4)
            
            
        }
    }
}

#Preview {
    RecentChartsVIew()
}
