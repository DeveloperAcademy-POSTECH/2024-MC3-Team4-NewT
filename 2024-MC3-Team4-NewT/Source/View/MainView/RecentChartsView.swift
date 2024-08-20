import SwiftUI
import SwiftData

struct RecentChartsView: View {
//    @Environment(\.modelContext) var modelContext
    @StateObject private var viewModel = RecordChartViewModel()
    @Query(sort: \ChartRow.time) var chartRows: [ChartRow]
    @Query(sort: \OldSurfingRecordOne.surfingStartTime) var surfingRecords: [OldSurfingRecordOne]
    @State private var evaluationValue: Int?
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("최근 기록 차트")
                    .font(.Heading3Bold)
                    .foregroundColor(.white)
                Spacer()
                Button {
                    // "모두 보기" 버튼을 누르면 전체 차트로 이동
                } label: {
                    HStack(alignment: .center, spacing: 2) {
                        NavigationLink(destination: RecordChartView()) {
                            Text("모두 보기").font(.Body2SemiBold)
                        }
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.white)
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
                        }
                        .foregroundColor(.black.opacity(0.5))
                        .padding(.horizontal, 24)
                        .padding(.top, 3)
                        
                        Rectangle()
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.surfBlue.opacity(0.3))
                            .padding(0)
                        
                        ForEach(viewModel.latestCharts(), id: \.id) { row in
                            HStack {
                                VStack {
                                    Text(DateFormatterManager.shared.formatDate(row.surfingRecordStartTime, format: "M/d"))
                                        .font(.Body2SemiBold)
                                    Text(DateFormatterManager.shared.timeToHourFormatter(row.surfingRecordStartTime))
                                        .font(.CaptionMedium)
                                }
                                Spacer()
                                HStack {
                                    Image("waveDirectionIcon2").rotationEffect(Angle(degrees: Double(row.surfingValues.windDirection)))
                                    Text("\(row.surfingValues.windSpeed, specifier: "%.1f")m/s")
                                        .font(.Body2Medium)
                                }
                                Spacer()
                                HStack {
                                    Image("swellDirectionIcon").rotationEffect(Angle(degrees: Double(row.surfingValues.waveDirection)))
                                    VStack {
                                        Text("\(row.surfingValues.waveHeight, specifier: "%.1f")m")
                                            .font(.Body2Medium)
                                        Text("\(row.surfingValues.wavePeriod, specifier: "%.1f")s")
                                            .font(.CaptionMedium)
                                    }
                                }
                                Spacer()
                                VStack(spacing: 0) {
                                    Text("\(row.surfingValues.waterTemperature, specifier: "%.0f")°C")
                                        .font(.Body2Medium)
                                    Image("waterTemperate")
                                }
                                Spacer()
                                HStack(spacing: 4) {
                                    Image("recentStarIcon")
                                    if let value = evaluationValue(for: row) {
                                        Text("\(value)점")
                                            .font(.Body2Medium)
                                    } else {
                                        Text("5점")
                                            .font(.Body2Medium)
                                    }
                                }
                            }
                            .padding(.horizontal, 19)
                            .padding(.vertical, 6)
                            
                            if row != viewModel.latestCharts().last {
                                Rectangle()
                                    .frame(height: 1)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.surfBlue.opacity(0.3))
                                    .padding(0)
                            }
                        }
                    }
                }
            }
            .background(.white.opacity(0.5))
            .cornerRadius(24)
            
            Spacer()
        }
        .onAppear {
            viewModel.chartRow = chartRows
        }
    }
}

extension RecentChartsView {
    private func evaluationValue(for row: ChartRow) -> Int? {
        // ChartRow의 id를 사용하여 관련 SurfingRecordOne을 찾기
        for record in surfingRecords {
            if let matchingChartRow = record.charts.first(where: { $0.id == row.id }) {
                print(record.evaluationValue)
                print("실행됨.")
                return record.evaluationValue
            }
        }
        print("실행되었지만 찾지 못함")
        return nil
    }
    //하..
}
