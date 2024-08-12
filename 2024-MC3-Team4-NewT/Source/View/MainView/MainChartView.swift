import SwiftUI
import SwiftData

struct MainChartView: View {
    @Environment(\.modelContext) private var modelContext
    var fbo = OldFirebaseObservable()
    @Query(filter:#Predicate<ChartRow>{ item in
        item.surfingRecordStartTime == nil
        
    },sort: \ChartRow.time) var chartRow: [ChartRow]
    @Binding var isHeaderVisible: Bool // 헤더 가시성 상태 변수
    @State private var topDate: String = ""
    
    var body: some View {
        VStack {
            Text(topDate.isEmpty ? DateFormatterManager.shared.dateFormatter.string(from: Date()) : topDate)
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
                            EmptyView()
                                .background(
                                    GeometryReader { geo in
                                        Color.clear.onChange(of: geo.frame(in: .global).minY) { _ in
                                            // 스크롤 위치에 따라 상단 날짜 업데이트
                                            if geo.frame(in: .global).minY < 100 && geo.frame(in: .global).maxY > -100 {
                                                DispatchQueue.main.async {
                                                    let currentDate = DateFormatterManager.shared.shortDateFormatter.date(from: key)
                                                    
                                                    // 날짜 업데이트 확인용
                                                    print("Current Date String: \(key)")
                                                    print("Parsed Date: \(String(describing: currentDate))")
                                                    
                                                    if let currentDate = currentDate {
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
                                        Text("\(DateFormatterManager.shared.timeToHourFormatter(chart.time))")
                                            .font(.Body2Medium)
                                            .frame(width: 35)
                                        
                                        HStack(alignment: .center, spacing: 8) {
                                            Image("waveDirectionIcon2")
                                                .frame(width: 14, height: 18)
                                                .rotationEffect(Angle(degrees: Double(chart.surfingValues.windDirection)))
                                            
                                            Text("\(chart.surfingValues.windSpeed, specifier: "%.1f")m/s")
                                                .font(.Body1Medium)
                                        }
                                        .frame(width: 80)
                                        
                                        HStack(alignment: .center, spacing: 8) {
                                            Image("swellDirectionIcon")
                                                .rotationEffect(Angle(degrees: Double(chart.surfingValues.waveDirection)))
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
                                                .font(.caption)
                                            //                                            Image("waterTemperate")
                                        }
                                        .frame(width: 60)
                                        
                                        HStack(alignment: .center, spacing: 8) {
                                            Image(chart.surfingValues.weather)
                                            Text("\(chart.surfingValues.airTemperature, specifier: "%.0f")°C")
                                                .font(.Body1Medium)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .frame(height: 60)
                                }
                            }
                            .padding(.horizontal)
                            Divider()
                                .frame(minHeight: 5)
                                .background(Color(.gray).opacity(0.1)) 
                                .edgesIgnoringSafeArea(.horizontal)
                                
                            
                        }
                        .id(key) // 날짜를 식별자로 사용
                        
                    }
                }
                .padding(.bottom, 80) //탭 바 여백 남겨둠
            }
            
        }
        .frame(maxWidth: .infinity)
        .background(.white.opacity(0.8))
        .cornerRadius(24)
        .onAppear {
            if let firstSection = fbo.groupedByDate(chartRow: chartRow).first?.key {
                print("First Section Key: \(firstSection)")
                
                let initialDate = DateFormatterManager.shared.shortDateFormatter.date(from: firstSection)
                
                print("Initial Date: \(String(describing: initialDate))")
                
                if let initialDate = initialDate {
                    topDate = initialDate.addingDays(1).formattedDate()
                }
            }
        }
        Spacer()
    }
    
    func formattedTime(from string: String) -> String {
        if let date = DateFormatterManager.shared.dateFromString(string) {
            return DateFormatterManager.shared.timeFormatter.string(from: date)
        }
        return string
    }
}

extension Date {
    func addingDays(_ days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
    }
    
    func formattedDate() -> String {
        DateFormatterManager.shared.dateFormatter.string(from: self)
    }
}
