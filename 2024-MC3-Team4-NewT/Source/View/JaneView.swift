//
//  JaneVIew.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/21/24.
//

import SwiftUI
import SwiftData

let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH시"
    formatter.locale = Locale(identifier: "ko_kr")
    return formatter
}()

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
        
        
        //MARK: MainChartView로 뺄 예정
        Text("주간 차트").font(.title3)
        Text("\(dateFormatter.string(from: Date()))")
        ScrollView {
            VStack {
                ForEach(sortedKeys, id: \.self) { date in
                    if let weatherList = groupedWeather[date] {
                        VStack {
                            Text(date)
                                .font(.headline)
                            HStack(alignment: .center, spacing: 8) {
                                Text("시간")
                                Text("바람")
                                Text("파도")
                                Text("수온")
                                Text("날씨")
                            }
                        
                            ForEach(weatherList) { weather in // weather는 이제 Identifiable
                                ForEach(weather.chartCollection) { chart in // chart도 Identifiable
                                    ChartRowView(chart: chart)
                                }
                            }
                        }
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
            }
        }
//        .onAppear{
//            addDummyData()
//        }
    }
    
    struct ChartRowView: View {
        var chart: ChartRow // ChartRowTmp에 맞는 프로퍼티를 정의합니다.
        var body: some View {
            HStack{
                Text("\(timeFormatter.string(from: chart.day))").textScale(.secondary)
                HStack(alignment: .center, spacing: 8) {
                    Image(systemName: "location.north")
                    Text("\(chart.surfingValues.windSpeed, specifier: "%.1f")m/s").textScale(.secondary)
                }
                HStack(alignment: .center, spacing: 8) {
                    Image(systemName: "location.north.fill")
                    VStack {
                        Text("\(chart.surfingValues.waveHeight, specifier: "%.1f")m").textScale(.secondary)
                        Text("\(chart.surfingValues.wavePeriod, specifier: "%.1f")s").textScale(.secondary)
                    }
                }
                Text("\(chart.surfingValues.waterTemperature, specifier: "%.0f")°C").textScale(.secondary)
                HStack(alignment: .center, spacing: 8) {
                    Text(chart.surfingValues.weather).textScale(.secondary)
                    Text("\(chart.surfingValues.airTemperature, specifier: "%.0f")°C").textScale(.secondary)
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
            let dummyDailyCharts = DailyWeather(id: UUID(), day: dummyDay, chartCollection: dummyChartRows)
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

