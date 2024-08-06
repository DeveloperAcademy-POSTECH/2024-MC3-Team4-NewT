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

//test
/// 원본 문자열에서 Date 객체로 변환하기 위한 Formatter
let inputDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    formatter.locale = Locale(identifier: "ko_kr")
    return formatter
}()

struct MainChartView: View {
    @Environment(\.modelContext) private var modelContext
    var fbo = FirebaseObservable()
    @Query(sort: \ChartRow.time) var chartRow: [ChartRow]
    @Binding var isHeaderVisible: Bool // 헤더 가시성 상태 변수
    var today: String = "2024-07-30" // 오늘 날짜 (예: "2024-07-30")
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 0) {
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
                .padding(.vertical, 2)
                .foregroundColor(.black.opacity(0.5))
                .background(Color(red: 0.9, green: 0.93, blue: 0.98).opacity(0.5))
                
                ScrollView {
                    GeometryReader { geometry in
                        let totalWidth = geometry.size.width
                        let columnWidth = totalWidth / 5  // 5열로 나누기
                        
                        ForEach(fbo.groupedByDate(chartRow: chartRow), id: \.key) { (key, charts) in
                            VStack(alignment: .leading) {
                                Text(key)
                                    .font(.headline)
                                    .padding(.top)
                                
                                Grid(alignment: .leadingFirstTextBaseline,
                                     horizontalSpacing: 20) {
                                    ForEach(charts, id: \.time) { chart in
                                        GridRow(alignment: .center) {
                                            Text("\(formattedTime(from: chart.time))")
                                                .font(.Body2Medium)
                                                .frame(width: columnWidth, alignment: .leading)
                                            
                                            HStack(alignment: .center, spacing: 8) {
                                                Image("waveDirectionIcon")
                                                    .frame(width: 14, height: 18)
                                                Text("\(chart.surfingValues.windSpeed, specifier: "%.1f")m/s")
                                                    .font(.Body1Medium)
                                            }
                                            .frame(width: columnWidth, alignment: .leading)
                                            
                                            HStack(alignment: .center, spacing: 8) {
                                                Image("swellDirectionIcon")
                                                VStack(alignment: .center, spacing: 0) {
                                                    Text("\(chart.surfingValues.waveHeight, specifier: "%.1f")m")
                                                        .font(.Body1Medium)
                                                    Text("\(chart.surfingValues.wavePeriod, specifier: "%.1f")s")
                                                        .font(.CaptionMedium)
                                                }
                                            }
                                            .frame(width: columnWidth, alignment: .leading)
                                            
                                            VStack(alignment: .center, spacing: 2) {
                                                Text("\(chart.surfingValues.waterTemperature, specifier: "%.0f")°C")
                                                    .font(.Body1Medium)
                                                Image("waterTemperate")
                                            }
                                            .frame(width: columnWidth, alignment: .leading)
                                            
                                            HStack(alignment: .center, spacing: 8) {
                                                Text(chart.surfingValues.weather)
                                                    .font(.Body1Medium)
                                                Text("\(chart.surfingValues.airTemperature, specifier: "%.0f")°C")
                                                    .font(.Body1Medium)
                                            }
                                            .frame(width: columnWidth, alignment: .leading)
                                        }
                                        .frame(height: 50)
                                    }
                                }
                            }
                        }
                    }
                }.padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity)
        .background(.white.opacity(0.8))
        .cornerRadius(24)
        .onAppear{
            //                addDummyData()
        }
        Spacer()
    }
    
    
}



extension MainChartView {
    func weatherIcon(weather: String) {
        if weather == ""{
            
        }
    }
    
    func addDummyData() {
        let context = modelContext //modelContext 가져옴
        let dummyDay = "2024-07-30"
        let dummyDailyCharts = DailyWeatherOld(day: dummyDay, chartCollection: dummyChartRows)
        context.insert(dummyDailyCharts)
        
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
    func formattedTime(from string: String) -> String {
            if let date = inputDateFormatter.date(from: string) {
                return timeFormatter.string(from: date)
            }
            return string
        }
    
    func groupedByDate(chartRow: [ChartRow]) -> [String: [ChartRow]] {
            var grouped = [String: [ChartRow]]()
            for chart in chartRow {
                if let date = inputDateFormatter.date(from: chart.time) {
                    let dateString = dateFormatter.string(from: date)
                    if grouped[dateString] == nil {
                        grouped[dateString] = [ChartRow]()
                    }
                    grouped[dateString]?.append(chart)
                }
            }
            return grouped
        }
}

