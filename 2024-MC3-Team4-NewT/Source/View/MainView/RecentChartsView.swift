import SwiftUI
import SwiftData

struct RecentChartsView: View {
    @StateObject private var viewModel = RecordChartViewModel()
    @Query(sort: \ChartRow.time) var chartRows: [ChartRow]
    @Query(sort: \SurfingRecordOne.surfingStartTime) var surfingRecords: [SurfingRecordOne]
    
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
                        .padding(.vertical, 3)
                        
                        Rectangle()
                            .frame(width: .infinity, height: 1)
                            .foregroundColor(.surfBlue.opacity(0.3))
                        
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
                                    Image("waveDirectionIcon2")
                                    Text("\(row.surfingValues.windSpeed, specifier: "%.1f")m/s")
                                        .font(.Body2Medium)
                                }
                                Spacer()
                                HStack {
                                    Image("swellDirectionIcon")
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
                                    if let evaluationValue = viewModel.evaluationValue(for: row) {
                                        Text("\(evaluationValue)점")
                                            .font(.Body2Medium)
                                    } else {
                                        Text("평가 없음")
                                            .font(.Body2Medium)
                                    }
                                }
                            }
                            .padding(.horizontal, 19)
                            .padding(.vertical, 6)
                            
                            if row != viewModel.latestCharts().last {
                                Rectangle()
                                    .frame(width: .infinity, height: 1)
                                    .foregroundColor(.surfBlue.opacity(0.3))
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

