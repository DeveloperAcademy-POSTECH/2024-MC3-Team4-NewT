//
//  RecentChartsVIew.swift
//  2024-MC3-Team4-NewT
//
//  Created by 김이예은 on 7/31/24.
//

import SwiftUI

struct RecentChartsView: View {
    private var dummyCharts: [ChartRowTmp]
    = [ChartRowTmp(day: Date(), surfingValues: SurfingValuesOne(waveDirection: 164.0, waveHeight: 0.16, wavePeriod: 4.75, windDirection: 234.36, windSpeed: 5.0, weather: "ra", airTemperature: 25.33, waterTemperature: 23.5), isHighTide: false, isLowTide: false),
       ChartRowTmp(day: Date(), surfingValues: SurfingValuesOne(waveDirection: 164.0, waveHeight: 0.16, wavePeriod: 4.75, windDirection: 234.36, windSpeed: 5.0, weather: "ra", airTemperature: 25.33, waterTemperature: 23.5), isHighTide: false, isLowTide: false),
       ChartRowTmp(day: Date(), surfingValues: SurfingValuesOne(waveDirection: 164.0, waveHeight: 0.16, wavePeriod: 4.75, windDirection: 234.36, windSpeed: 5.0, weather: "ra", airTemperature: 25.33, waterTemperature: 23.5), isHighTide: false, isLowTide: false)
    ]
    
    var body: some View {
        VStack(spacing: 0){
            HStack{
                Text("최근 기록 차트")
                    .font(.Heading3Bold)
                    .foregroundColor(.white)
                Spacer()
                Button{
                    
                } label: {
                    HStack(alignment: .center, spacing: 2){
                        NavigationLink(destination: RecordChartView()){
                            Text("모두 보기").font(.Body2SemiBold)
                        }
                        
                        Image(systemName: "chevron.right")
                    }.foregroundColor(.white)
                }
            }
            .padding(.bottom, 8)
            
            VStack {
                HStack {
                    Grid {
                        HStack(alignment: .center) {
                            Text("시간").font(.CaptionSemiBold)
                            Spacer()
                            Text("바람").font(.CaptionSemiBold)
                            Spacer()
                            Text("파도").font(.CaptionSemiBold)
                            Spacer()
                            Text("수온").font(.CaptionSemiBold)
                            Spacer()
                            Text("평가").font(.CaptionSemiBold)
                        }.foregroundColor(.black.opacity(0.5))
                            .padding(.horizontal, 24)
                            .padding(.vertical, 3)
                        Rectangle().frame(width: .infinity, height: 1).foregroundColor(.surfBlue.opacity(0.3))
                        HStack{
                            VStack {
                                Text("7/20").font(.Body2SemiBold)
                                Text("03시").font(.CaptionMedium)
                            }
                            Spacer()
                            HStack {
                                Image("waveDirectionIcon")
                                Text("3.3m/s").font(.Body2Medium)
                            }.padding(.leading, -15)
                            Spacer()
                            HStack {
                                Image("swellDirectionIcon")
                                VStack {
                                    Text("0.2m").font(.Body2Medium)
                                    Text("3.4s").font(.CaptionMedium)
                                }
                            }.padding(.leading, -20)
                            Spacer()
                            VStack(spacing: 0) {
                                Text("28도").font(.Body2Medium)
                                Image("waterTemperate")
                            }.padding(.trailing, -5)
                            Spacer()
                            HStack(spacing: 4) {
                                Image("recentStarIcon")
                                Text("5점").font(.Body2Medium)
                            }
                            
                        }.padding(.horizontal, 19)
                            .padding(.vertical, 6)
                        HStack{
                            VStack {
                                Text("7/20").font(.Body2SemiBold)
                                Text("03시").font(.CaptionMedium)
                            }
                            Spacer()
                            HStack {
                                Image("waveDirectionIcon")
                                Text("3.3m/s").font(.Body2Medium)
                            }.padding(.leading, -15)
                            Spacer()
                            HStack {
                                Image("swellDirectionIcon")
                                VStack {
                                    Text("0.2m").font(.Body2Medium)
                                    Text("3.4s").font(.CaptionMedium)
                                }
                            }.padding(.leading, -20)
                            Spacer()
                            VStack(spacing: 0) {
                                Text("28도").font(.Body2Medium)
                                Image("waterTemperate")
                            }.padding(.trailing, -5)
                            Spacer()
                            HStack(spacing: 4) {
                                Image("recentStarIcon")
                                Text("5점").font(.Body2Medium)
                            }
                            
                        }.padding(.horizontal, 19)
                            .padding(.vertical, 6)
                        HStack{
                            VStack {
                                Text("7/20").font(.Body2SemiBold)
                                Text("03시").font(.CaptionMedium)
                            }
                            Spacer()
                            HStack {
                                Image("waveDirectionIcon")
                                Text("3.3m/s").font(.Body2Medium)
                            }.padding(.leading, -15)
                            Spacer()
                            HStack {
                                Image("swellDirectionIcon")
                                VStack {
                                    Text("0.2m").font(.Body2Medium)
                                    Text("3.4s").font(.CaptionMedium)
                                }
                            }.padding(.leading, -20)
                            Spacer()
                            VStack(spacing: 0) {
                                Text("28도").font(.Body2Medium)
                                Image("waterTemperate")
                            }.padding(.trailing, -5)
                            Spacer()
                            HStack(spacing: 4) {
                                Image("recentStarIcon")
                                Text("5점").font(.Body2Medium)
                            }
                            
                        }.padding(.horizontal, 19)
                            .padding(.vertical, 6)
                    }
                }
            }
            .background(.white.opacity(0.5))
            .cornerRadius(24)
            //            .padding()
            Spacer()
        }
        
    }
}

#Preview {
    RecentChartsView()
}
