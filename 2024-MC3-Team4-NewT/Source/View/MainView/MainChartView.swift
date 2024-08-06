import SwiftUI
import SwiftData

/// 'HH시'로 표시해주는 Formatter
let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH시"
    formatter.locale = Locale(identifier: "ko_kr")
    return formatter
}()

/// 'M월 d일 EEEE'로 표시해주는 Formatter
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "M월 d일 EEEE"
    formatter.locale = Locale(identifier: "ko_kr")
    return formatter
}()

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
    @State private var currentSection: String = ""
    var today: String = "2024-07-30" // 오늘 날짜 (예: "2024-07-30")
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 0) {
                Text(currentSection.isEmpty ? dateFormatter.string(from: Date()) : currentSection)
                    .padding(.vertical, 10)
                    .font(.SubheadingBold)
                    .foregroundColor(.surfBlue)
                
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
                    VStack(spacing: 0) {
                        ForEach(groupedByDate(chartRow: chartRow), id: \.key) { (key, charts) in
                            VStack(alignment: .leading, spacing: 0) {
                                Text(key)
                                    .font(.headline)
                                    .padding(.top)
                                    .background(GeometryReader { geo in
                                        Color.clear.onAppear {
                                            if geo.frame(in: .global).minY < 100 {
                                                currentSection = key
                                            }
                                        }
                                    })
                                
                                VStack {
                                    ForEach(charts, id: \.time) { chart in
                                        HStack {
                                            Text("\(formattedTime(from: chart.time))")
                                                .font(.Body2Medium)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                            HStack(alignment: .center, spacing: 8) {
                                                Image("waveDirectionIcon")
                                                    .frame(width: 14, height: 18)
                                                Text("\(chart.surfingValues.windSpeed, specifier: "%.1f")m/s")
                                                    .font(.Body1Medium)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                            HStack(alignment: .center, spacing: 8) {
                                                Image("swellDirectionIcon")
                                                VStack(alignment: .center, spacing: 0) {
                                                    Text("\(chart.surfingValues.waveHeight, specifier: "%.1f")m")
                                                        .font(.Body1Medium)
                                                    Text("\(chart.surfingValues.wavePeriod, specifier: "%.1f")s")
                                                        .font(.CaptionMedium)
                                                }
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                            VStack(alignment: .center, spacing: 2) {
                                                Text("\(chart.surfingValues.waterTemperature, specifier: "%.0f")°C")
                                                    .font(.Body1Medium)
                                                Image("waterTemperate")
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                            HStack(alignment: .center, spacing: 8) {
                                                Text(chart.surfingValues.weather)
                                                    .font(.Body1Medium)
                                                Text("\(chart.surfingValues.airTemperature, specifier: "%.0f")°C")
                                                    .font(.Body1Medium)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .frame(height: 50)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.bottom, 160)  // 차트 하단 패딩 추가
                }
                .padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity)
        .background(.white.opacity(0.8))
        .cornerRadius(24)
        .onAppear {
            if let firstSection = groupedByDate(chartRow: chartRow).first?.key {
                currentSection = firstSection
            }
        }
        Spacer()
    }
    
    func formattedTime(from string: String) -> String {
        if let date = inputDateFormatter.date(from: string) {
            return timeFormatter.string(from: date)
        }
        return string
    }
    
    func groupedByDate(chartRow: [ChartRow]) -> [(key: String, value: [ChartRow])] {
        // 날짜별로 그룹화
        let grouped = Dictionary(grouping: chartRow) { item -> String in
            String(item.time.prefix(10)) // 날짜 부분만 추출하여 그룹화
        }
        
        // 키를 정렬하여 배열로 반환
        return grouped.sorted { $0.key < $1.key }
    }
}

extension MainChartView {
    func weatherIcon(weather: String) {
        if weather == "" {
            // Implementation here
        }
    }
    
    func addDummyData() {
        let context = modelContext // modelContext 가져옴
        let dummyDay = "2024-07-30"
        let dummyDailyCharts = DailyWeatherOld(day: dummyDay, chartCollection: dummyChartRows)
        context.insert(dummyDailyCharts)
        
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
