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

// 추가된 포맷터
let dateKeyFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.locale = Locale(identifier: "ko_kr")
    return formatter
}()

extension Date {
    func addingDays(_ days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
    }
    
    func formattedDate() -> String {
        dateFormatter.string(from: self)
    }
}

struct MainChartView: View {
    @Environment(\.modelContext) private var modelContext
    var fbo = FirebaseObservable()
    @Query(sort: \ChartRow.time) var chartRow: [ChartRow]
    @Binding var isHeaderVisible: Bool // 헤더 가시성 상태 변수
    @State private var topDate: String = ""
    
    var body: some View {
        VStack {
            // 상단 날짜 및 차트 헤더 표시
            Text(topDate.isEmpty ? dateFormatter.string(from: Date()) : topDate)
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
                LazyVStack(spacing: 0) {
                    ForEach(fbo.groupedByDate(chartRow: chartRow), id: \.key) { (key, charts) in
                        VStack(alignment: .leading, spacing: 0) {
                            // 각 날짜별 차트 헤더
                            Text(key)
                                .font(.headline)
                                .padding(.top)
                                .background(
                                    GeometryReader { geo in
                                        Color.clear.onChange(of: geo.frame(in: .global).minY) { _ in
                                            // 스크롤 위치에 따라 상단 날짜 업데이트
                                            if geo.frame(in: .global).minY < 100 && geo.frame(in: .global).maxY > -100 {
                                                DispatchQueue.main.async {
                                                    let currentDate = dateKeyFormatter.date(from: key)
                                                    
                                                    // 디버깅을 위한 print문 추가
                                                    print("Current Date String: \(key)")
                                                    print("Parsed Date: \(String(describing: currentDate))")
                                                    
                                                    if let currentDate = currentDate {
//                                                        let previousDate = currentDate.addingDays().formattedDate()
                                                        topDate = currentDate.addingDays(1).formattedDate()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                )
                            
                            // 각 차트 항목
                            LazyVStack(spacing: 0) {
                                ForEach(charts, id: \.time) { chart in
                                    HStack {
                                        Text("\(formattedTime(from: chart.time))")
                                            .font(.Body2Medium)
                                            .frame(width: 35)
                                        
                                        HStack(alignment: .center, spacing: 8) {
                                            Image("waveDirectionIcon")
                                                .frame(width: 14, height: 18)
                                            Text("\(chart.surfingValues.windSpeed, specifier: "%.1f")m/s")
                                                .font(.Body1Medium)
                                        }
                                        .frame(width: 80)
                                        
                                        HStack(alignment: .center, spacing: 8) {
                                            Image("swellDirectionIcon")
                                            VStack(alignment: .center, spacing: 0) {
                                                Text("\(chart.surfingValues.waveHeight, specifier: "%.1f")m")
                                                    .font(.Body1Medium)
                                                Text("\(chart.surfingValues.wavePeriod, specifier: "%.1f")s")
                                                    .font(.CaptionMedium)
                                            }
                                        }
                                        .frame(width: 70)
                                        .padding(.trailing, 12)
                                        
                                        VStack(alignment: .center, spacing: 2) {
                                            Text("\(chart.surfingValues.waterTemperature, specifier: "%.0f")°C")
                                                .font(.Body1Medium)
                                            Image("waterTemperate")
                                        }
                                        .frame(width: 60)
                                        
                                        HStack(alignment: .center, spacing: 8) {
                                            Image("sunIcon")
                                            Text("\(chart.surfingValues.airTemperature, specifier: "%.0f")°C")
                                                .font(.Body1Medium)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .frame(height: 50)
                                }
                            }
                        }
                        .id(key) // 날짜를 식별자로 사용
                    }
                }
                .padding(.bottom, 80)  // 차트 하단 패딩 추가
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .background(.white.opacity(0.8))
        .cornerRadius(24)
        .onAppear {
            if let firstSection = fbo.groupedByDate(chartRow: chartRow).first?.key {
                // 디버깅을 위한 print문 추가
                print("First Section Key: \(firstSection)")
                
                let initialDate = dateKeyFormatter.date(from: firstSection)
                
                // 디버깅을 위한 print문 추가
                print("Initial Date: \(String(describing: initialDate))")
                
                if let initialDate = initialDate {
                    topDate = initialDate.formattedDate()
                }
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
}

extension MainChartView {
    func weatherIcon(weather: String) {
        if weather == "" {
            //아이콘 보여주기
        }
    }
}
