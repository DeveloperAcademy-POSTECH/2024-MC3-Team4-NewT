//
//  JaneVIew.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/21/24.
//

import SwiftUI
import SwiftData

///'@@시 (24시제)'로 표시해주는 Formatter
let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH시"
    formatter.locale = Locale(identifier: "ko_kr")
    return formatter
}()

///'@월 %일 &요일'로 표시해주는 Formatter
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "M월 d일 EEEE"
    formatter.locale = Locale(identifier: "ko_kr")
    return formatter
}()

struct JaneView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var dailyWeather: [DailyWeather]
    var today: String = "2024-07-30" // 오늘 날짜 (예: "2024-07-30")
    
    var body: some View {
        
        // 날짜별로 그룹화
        let groupedWeather = Dictionary(grouping: dailyWeather, by: { $0.day })
        
        // 오늘 날짜를 가장 위에 두고 나머지 날짜 정렬
        let sortedKeys = ([today] + groupedWeather.keys.filter { $0 != today }).sorted()
        
        //        FitChartView()
        //MARK: MainChartView로 뺄 예정
        
        VStack {
            ForEach(sortedKeys, id: \.self) { date in
                if let weatherList = groupedWeather[date] {
                    VStack(alignment: .center, spacing: 8) {
                        Text("\(dateFormatter.string(from: Date()))")
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
                        .background(.brightGray)
                        
                        ScrollView {
                            Grid(alignment: .leadingFirstTextBaseline,
                                 horizontalSpacing: 20) {
                                
                                ForEach(weatherList) { weather in // weather는 이제 Identifiable
                                    ForEach(weather.chartCollection, id: \.self) { chart in // chart도 Identifiable
                                        //                                    TestView(chart: chart)
                                        GridRow {
                                            Text("\(timeFormatter.string(from: chart.day))").font(.Body2Medium)
                                            HStack(alignment: .center, spacing: 8) {
                                                Image("waveDirectionIcon")
                                                Text("\(chart.surfingValues.windSpeed, specifier: "%.1f")m/s").font(.Body1Medium)
                                            }.frame(width: 80)
                                            
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
                                            }.frame(width: 56)
                                            HStack(alignment: .center, spacing: 8) {
                                                Text(chart.surfingValues.weather).font(.Body1Medium)
                                                Text("\(chart.surfingValues.airTemperature, specifier: "%.0f")°C").font(.Body1Medium)
                                            }.frame(width: 56)
                                        }.background {
                                            Rectangle()
                                                .fill(.surfBlue.opacity(0.1)) // 선의 색상
                                                .frame(height: 1) // 선의 두께
//                                                .padding(.horizontal) // 좌우 여백
                                        }
                                        .frame(height: 50)
                                    }
                                }
                            }
                        }.padding(.horizontal)
                    }
                }
            }
            
        }.frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(24)
        Spacer()
    }
    
    ///한 줄 차트 뷰
    struct ChartRowView: View {
        var chart: ChartRowTmp // ChartRowTmp에 맞는 프로퍼티를 정의합니다.
        var body: some View {
            ZStack(alignment: .bottom){
                HStack(alignment: .center, spacing: 4){
                    Text("\(timeFormatter.string(from: chart.day))").font(.Body2Medium)
                    HStack(alignment: .center, spacing: 8) {
                        Image("waveDirectionIcon")
                        Text("\(chart.surfingValues.windSpeed, specifier: "%.1f")m/s").font(.Body1Medium)
                    }
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
                    HStack(alignment: .center, spacing: 8) {
                        Text(chart.surfingValues.weather).font(.Body1Medium)
                        Text("\(chart.surfingValues.airTemperature, specifier: "%.0f")°C").font(.Body1Medium)
                    }
                }.frame(maxWidth: .infinity).frame(height: 63)
                    .padding(.horizontal)
            }
            Rectangle()
                .fill(.surfBlue.opacity(0.1)) // 선의 색상
                .frame(height: 1) // 선의 두께
                .padding(.horizontal) // 좌우 여백
        }
    }
    
    struct TestView: View {
        var chart: ChartRowTmp // ChartRowTmp에 맞는 프로퍼티를 정의합니다.
        var body: some View {
            Grid(alignment: .leadingFirstTextBaseline,
                 horizontalSpacing: 15) {
                GridRow {
                    Text("\(timeFormatter.string(from: chart.day))").font(.Body2Medium)
                    HStack(alignment: .center, spacing: 8) {
                        Image("waveDirectionIcon")
                        Text("\(chart.surfingValues.windSpeed, specifier: "%.1f")m/s").font(.Body1Medium)
                    }
                    
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
                    HStack(alignment: .center, spacing: 8) {
                        Text(chart.surfingValues.weather).font(.Body1Medium)
                        Text("\(chart.surfingValues.airTemperature, specifier: "%.0f")°C").font(.Body1Medium)
                    }
                }.background {
                    Rectangle()
                        .fill(.surfBlue.opacity(0.1)) // 선의 색상
                        .frame(height: 1) // 선의 두께
                        .padding(.horizontal) // 좌우 여백
                }
            }
        }
    }
}


extension JaneView {
    func weatherIcon() {
        
    }
    
    func addDummyData() {
        let context = modelContext //modelContext 가져옴
        let dummyDay = "2024-07-30"
        let dummyDailyCharts = DailyWeather(day: dummyDay, chartCollection: dummyChartRows)
        context.insert(dummyDailyCharts)
        
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
    //        func ChartRowList() {
    //            var chartRows: [ChartRow] = dummyChartRows
    //            ForEach(chartRows) { row in
    //                Text("\(daysFormatter.string(from: row.day))").textScale(.secondary)
    //                HStack(alignment: .center, spacing: 8) {
    //                    Image(systemName: "location.north")
    //                    Text("\(row.surfingValues.windSpeed, specifier: "%.1f")m/s").textScale(.secondary)
    //                }
    //                HStack(alignment: .center, spacing: 8) {
    //                    Image(systemName: "location.north.fill")
    //                    VStack {
    //                        Text("\(row.surfingValues.waveHeight, specifier: "%.1f")m").textScale(.secondary)
    //                        Text("\(row.surfingValues.wavePeriod, specifier: "%.1f")s").textScale(.secondary)
    //                    }
    //                }
    //                Text("\(row.surfingValues.waterTemperature, specifier: "%.0f")°C").textScale(.secondary)
    //                HStack(alignment: .center, spacing: 8) {
    //                    Text(row.surfingValues.weather).textScale(.secondary)
    //                    Text("\(row.surfingValues.airTemperature, specifier: "%.0f")°C").textScale(.secondary)
    //                }
    //            }
    //        }
    
}

