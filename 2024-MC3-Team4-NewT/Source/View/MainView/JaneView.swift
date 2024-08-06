//
//  JaneVIew.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/21/24.
//

import Foundation
import SwiftUI
import SwiftData

//MainChart뷰
struct JaneView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var dailyWeather: [DailyWeather]
//    @ObservedObject var viewModel: SwiftDataObservable
    @Binding var isHeaderVisible: Bool // 헤더 가시성 상태 변수
    var today: String = "2024-07-30" // 오늘 날짜 (예: "2024-07-30")
    let formattedDateTime = DateFormatterManager.shared.timeFormatter
    let formattedDatedate = DateFormatterManager.shared.dateFormatter
    
    var body: some View {
        
        // 날짜별로 그룹화
        //        let groupedWeather = Dictionary(grouping: dailyWeather, by: { $0.day })
        
        // 오늘 날짜를 가장 위에 두고 나머지 날짜 정렬
        //        let sortedKeys = ([today] + groupedWeather.keys.filter { $0 != today }).sorted()
        
        VStack {
            //            ForEach(sortedKeys, id: \.self) { date in
            //                if let weatherList = groupedWeather[date] {
            VStack(alignment: .center, spacing: 0) {
                Text("\(formattedDatedate.string(from: Date()))") //받아온 데이터의 날짜로 수정해야함
                    .padding(.vertical, 10)
                    .font(.SubheadingBold).foregroundColor(.surfBlue)
                HStack(alignment: .center) {
                    Text("  시간").font(.CaptionSemiBold)
                    Spacer()
                    Text(" 바람").font(.CaptionSemiBold)
                    Spacer()
                    Text("  파도").font(.CaptionSemiBold)
                    Spacer()
                    Text("수온   ").font(.CaptionSemiBold)
                    Spacer()
                    Text("날씨    ").font(.CaptionSemiBold)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 2)
                .foregroundColor(.black.opacity(0.5))
                .background(Color(red: 0.9, green: 0.93, blue: 0.98).opacity(0.5))
                
                ScrollView {
                    Grid(alignment: .leadingFirstTextBaseline,
                         horizontalSpacing: 20) {
                        
                        ForEach(dailyWeather) { weather in
                            ForEach(weather.chartCollection) { chart in
                                GridRow(alignment: .center) {
                                    Text("\(formattedDateTime.string(from: Date()))").font(.Body2Medium) //받아온 데이터의 시간으로 수정해야함
                                    HStack(alignment: .center, spacing: 8) {
                                        Image("waveDirectionIcon").frame(width: 14, height: 18)
                                        //                                                Image(systemName: "location.north").frame(width: 14, height: 18)
                                        Text("\(chart.surfingValues.windSpeed, specifier: "%.1f")m/s").font(.Body1Medium)
                                    }.frame(width: 76)
                                    
                                    HStack(alignment: .center, spacing: 8) {
                                        Image("swellDirectionIcon")
                                        VStack(alignment: .center, spacing: 0) {
                                            Text("\(chart.surfingValues.waveHeight, specifier: "%.1f")m").font(.Body1Medium)
                                            Text("\(chart.surfingValues.wavePeriod, specifier: "%.1f")s").font(.CaptionMedium)
                                        }
                                    }
                                    VStack(alignment: .center, spacing: 2) {
                                        Text("\(chart.surfingValues.waterTemperature, specifier: "%.0f")°C").font(.Body1Medium)
                                        Image("waterTemperate")
                                    }
                                    .frame(width: 56)
                                    HStack(alignment: .center, spacing: 8) {
                                        Text(chart.surfingValues.weather).font(.Body1Medium)
                                        //                                                Spacer()
                                        Text("\(chart.surfingValues.airTemperature, specifier: "%.0f")°C").font(.Body1Medium)
                                    }
                                }
                                .frame(height: 50)
                            }
                        }
                    }
                }.padding(.horizontal)
            }
            
        }.frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(24)
            .onAppear {
                for weather in dailyWeather {
//                    viewModel.createDailyWeather2(modelContext: modelContext, dailyWeather: weather)
                }
            }
        Spacer()
    }
    
}


extension JaneView {
    func weatherIcon(weather: String) {
        if weather == ""{
            
        }
    }
    func addDummyData(modelContext: ModelContext) {
        let context = modelContext
        let dummyDay = "2024-07-30"
        let dummyChartRows = [
            ChartRow(time: dummyDay, surfingValues: SurfingValues(waveDirection: 5.0, waveHeight: 2.0, wavePeriod: 8.0, windDirection: 24.0, windSpeed: 28.0, weather: "Sunny", airTemperature: 23.0, waterTemperature: 26.0), isHighTide: false, isLowTide: false),
            ChartRow(time: dummyDay, surfingValues: SurfingValues(waveDirection: 4.5, waveHeight: 1.8, wavePeriod: 7.5, windDirection: 24.5, windSpeed: 28.5, weather: "Cloudy", airTemperature: 23.0, waterTemperature: 26.0), isHighTide: false, isLowTide: false)
        ]
        let dummyDailyCharts = DailyWeather(day: dummyDay, chartCollection: dummyChartRows)
        context.insert(dummyDailyCharts)
        
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}

