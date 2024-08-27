//
//  SDMainChartView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/27/24.
//

import SwiftUI

struct SDMainChartView: View {
    @State var timeWidth = 40.0
    @State var windWidth = 80.0
    @State var waveWidth = 60.0
    @State var waterWidth = 40.0
    @State var weatherWidth = 70.0
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("7월 25일 목요일")
                    .font(.headline)
                    .padding(.top)
                
                Grid(alignment: .center, horizontalSpacing: 1, verticalSpacing: 10) {
                    GridRow {
                        Text("시간")
                            .frame(width:timeWidth,alignment: .center)
                        Text("바람")
                            .frame(minWidth: windWidth, maxWidth: .infinity, alignment: .center)
                        Text("파도")
                            .frame(minWidth: waveWidth, maxWidth: .infinity, alignment: .center)
                        Text("수온")
                            .frame(minWidth: waterWidth, maxWidth: .infinity, alignment: .center)
                        Text("날씨")
                            .frame(width:weatherWidth,alignment: .center)
                    }
                    .font(.subheadline)
                    .bold()
                    .background(Color(UIColor.systemGray6))
                    
                    ForEach(data) { item in
                        GridRow {
                            Text("\(item.time)시")
                                .font(.system(size:13))
                                .frame(width:timeWidth,alignment: .center)
                            
                            HStack {
                                Image("waveDirectionIcon2")
                                    .frame(width: 14, height: 18)
                                    .rotationEffect(Angle(degrees: Double(10.0)))
                                HStack(alignment: .top, spacing: 0) {
                                    Text(item.windSpeedValue)
                                        .font(.system(size: 15))
                                    Text("m/s")
                                        .font(.footnote)
                                }
                            }
                            .frame(minWidth: windWidth, maxWidth: .infinity, alignment: .center)
                            
                            // 파도
                            HStack {
                                Image("swellDirectionIcon")
                                    .rotationEffect(Angle(degrees: Double(330.0)))
                                VStack(alignment: .center, spacing: 2) {
                                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                                        Text(item.waveHeightValue)
                                            .font(.system(size: 15))
                                        Text("m")
                                            .font(.footnote)
                                    }
                                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                                        Text(item.wavePeriodValue)
                                            .font(.system(size: 15))
                                        Text("s")
                                            .font(.footnote)
                                    }
                                }
                            }
                            .frame(minWidth: waveWidth, maxWidth: .infinity, alignment: .center)
                            
                            // 수온
                            VStack(alignment: .center) {
                                HStack(alignment: .firstTextBaseline, spacing: 0) {
                                    Text(item.waterTempValue)
                                        .font(.system(size: 15))
                                    Text("℃")
                                        .font(.footnote)
                                }
                                Image("waterTemperate")
                            }
                            .frame(minWidth: waterWidth, maxWidth: .infinity, alignment: .center)
                            
                            HStack {
                                Image(systemName: item.weatherIcon)
                                HStack(alignment: .firstTextBaseline, spacing: 0) {
                                    Text(item.airTempValue)
                                        .font(.system(size: 15))
                                    Text("℃")
                                        .font(.footnote)
                                }
                            }
                            .frame(width:weatherWidth,alignment: .center)
                        }
                    }
                }
                
                Spacer()
                
            }
            .padding(.horizontal)
            .frame(width: geometry.size.width)
            .background(Color.white.opacity(0.8))
            .cornerRadius(24)
        }
    }
}

#Preview {
    NewMainView()
}



