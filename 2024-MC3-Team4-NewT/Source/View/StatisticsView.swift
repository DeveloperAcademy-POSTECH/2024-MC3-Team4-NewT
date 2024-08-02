//
//  StatisticsView.swift
//  2024-MC3-Team4-NewT
//
//  Created by 김이예은 on 7/31/24.
//

import SwiftUI
import SwiftData

func FloatToDouble(_ value: Float) -> Double {
    return Double(value.rounded())
}

struct StatisticsView: View {
    @Bindable var viewStatistics: Statistics
    var body: some View {
        VStack(alignment: .leading, spacing:0){
            HStack(alignment: .center) {
                Text("선호하는 차트 통계")
                    .font(.Heading3Bold)
                    .foregroundColor(.white)
                Spacer()
                Button {
                    print("자세히 보기")
                } label: {
                    Image("infoIcon")
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
                            Text("\(viewStatistics.windSpeed!, specifier: "%.1f")m/s")
                            
                                .font(.Heading1SemiBold)
                                .foregroundColor(Color("surfBlue"))
                            Spacer()
                            Image("waveDirectionIcon2")
                                .rotationEffect(.degrees(Double(FloatToDouble(viewStatistics.windDirection ?? 0))))
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
                                Text("\(viewStatistics.waveHeight ?? 0.0, specifier: "%.1f")m")
                                    .font(.Heading1SemiBold)
                                    .foregroundColor(Color("surfBlue"))
                                Text("\(viewStatistics.wavePeriod ?? 0.0, specifier: "%.1f")s")
                                    .font(.SubheadingSemiBold)
                                    .foregroundColor(Color("surfBlue"))
                            }
                            Spacer()
                            Image("swellDirectionIcon2")
                                .rotationEffect(.degrees(FloatToDouble(viewStatistics.waveDirection ?? 0)))
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

extension StatisticsView {
    
}
