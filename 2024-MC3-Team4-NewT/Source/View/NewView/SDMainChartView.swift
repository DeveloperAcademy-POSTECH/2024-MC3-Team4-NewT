//
//  SDMainChartView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/27/24.
//

import SwiftUI
import SwiftData

struct SDMainChartView: View {
    @State var mappedItem = "wolpo"
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var nfvm = NewFirebaseViewModel()
    @StateObject var chartViewModel = ChartViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Text("7월 25일 목요일")
                        .font(.headline)
                        .padding(.top)
                    
                    Grid(alignment: .center, horizontalSpacing: 1, verticalSpacing: 10) {
                        GridRow {
                            Text("시간")
                                .frame(width: chartViewModel.timeWidth, alignment: .center)
                            Text("바람")
                                .frame(minWidth: chartViewModel.windWidth, maxWidth: .infinity, alignment: .center)
                            Text("파도")
                                .frame(minWidth: chartViewModel.waveWidth, maxWidth: .infinity, alignment: .center)
                            Text("수온")
                                .frame(minWidth: chartViewModel.waterWidth, maxWidth: .infinity, alignment: .center)
                            Text("날씨")
                                .frame(width: chartViewModel.weatherWidth, alignment: .center)
                        }
                        .font(.subheadline)
                        .bold()
                        .background(Color(UIColor.systemGray6))
                        
                        ForEach(nfvm.SDDailySurfingValues, id: \.id) { item in
                            GridRow {
                                Text("\(DateFormatterManager.shared.timeToHourFormatter(item.time))")
                                    .font(.system(size: 13))
                                    .frame(width: chartViewModel.timeWidth, alignment: .center)
                                
                                HStack {
                                    Image("waveDirectionIcon2")
                                        .rotationEffect(Angle(degrees: Double(item.windDirection)))
                                    HStack(alignment: .top, spacing: 0) {
                                        Text("\(item.windSpeed, specifier: "%.1f")")
                                            .font(.system(size: 15))
                                        Text("m/s")
                                            .font(.footnote)
                                    }
                                }
                                .frame(minWidth: chartViewModel.windWidth, maxWidth: .infinity, alignment: .center)
                                
                                // 파도
                                HStack {
                                    Image("swellDirectionIcon")
                                        .rotationEffect(Angle(degrees: Double(item.waveDirection)))
                                    VStack(alignment: .center, spacing: 2) {
                                        HStack(alignment: .firstTextBaseline, spacing: 0) {
                                            Text("\(item.waveHeight, specifier: "%.1f")")
                                                .font(.system(size: 15))
                                            Text("m")
                                                .font(.footnote)
                                        }
                                        HStack(alignment: .firstTextBaseline, spacing: 0) {
                                            Text("\(item.wavePeriod, specifier: "%.1f")")
                                                .font(.system(size: 15))
                                            Text("s")
                                                .font(.footnote)
                                        }
                                    }
                                }
                                .frame(minWidth: chartViewModel.waveWidth, maxWidth: .infinity, alignment: .center)
                                
                                // 수온
                                VStack(alignment: .center) {
                                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                                        Text("\(item.waterTemperature, specifier: "%.1f")")
                                            .font(.system(size: 15))
                                        Text("℃")
                                            .font(.footnote)
                                    }
                                    Image("waterTemperate")
                                }
                                .frame(minWidth: chartViewModel.waterWidth, maxWidth: .infinity, alignment: .center)
                                
                                HStack {
                                    Image(item.weather)
                                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                                        Text("\(item.airTemperature, specifier: "%.1f")")
                                            .font(.system(size: 12))
                                        Text("℃")
                                            .font(.system(size:12))
                                    }
                                }
                                .frame(width: chartViewModel.weatherWidth, alignment: .center)
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
            .padding(.horizontal)
            .frame(width: geometry.size.width)
            .background(Color.white.opacity(0.8))
            .cornerRadius(24)
        }
        .onAppear {
            print("SDMainCHartView")
            nfvm.fetchFirebaseDailyChart(modelContext: modelContext, collectionName: mappedItem)
        }
    }
}
