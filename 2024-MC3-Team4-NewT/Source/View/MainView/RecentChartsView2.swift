import SwiftUI

struct RecentChartsView2: View {
    private var dummyCharts: [ChartRowTmp] = [
        ChartRowTmp(day: Date(), surfingValues: SurfingValuesOne(waveDirection: 164.0, waveHeight: 0.16, wavePeriod: 4.75, windDirection: 234.36, windSpeed: 5.0, weather: "ra", airTemperature: 25.33, waterTemperature: 23.5), isHighTide: false, isLowTide: false),
        ChartRowTmp(day: Date(), surfingValues: SurfingValuesOne(waveDirection: 164.0, waveHeight: 0.16, wavePeriod: 4.75, windDirection: 234.36, windSpeed: 5.0, weather: "ra", airTemperature: 25.33, waterTemperature: 23.5), isHighTide: false, isLowTide: false),
        ChartRowTmp(day: Date(), surfingValues: SurfingValuesOne(waveDirection: 164.0, waveHeight: 0.16, wavePeriod: 4.75, windDirection: 234.36, windSpeed: 5.0, weather: "ra", airTemperature: 25.33, waterTemperature: 23.5), isHighTide: false, isLowTide: false)
    ]
    
    let columns = [
        GridItem(.fixed(10)),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("최근 기록 차트")
                    .font(.Heading3Bold)
                    .foregroundColor(.white)
                Spacer()
                Button {
                    // Action for "모두 보기"
                } label: {
                    HStack(alignment: .center, spacing: 2) {
                        Text("모두 보기").font(.Body2SemiBold)
                        Image(systemName: "chevron.right")
                    }.foregroundColor(.white)
                }
            }
            .padding(.bottom, 8)
            
            VStack {
                LazyVGrid(columns: columns, spacing: 10) {
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
                    .frame(maxWidth: .infinity)
                    
                    Rectangle().frame(height: 1).foregroundColor(.surfBlue.opacity(0.3)).frame(maxWidth: .infinity)
                    
                    ForEach(dummyCharts){ chart in
                        HStack(alignment: .center) {
                            VStack {
                                Text("7/20").font(.Body2SemiBold)
                                Text("03시").font(.CaptionMedium)
                            }
//                            Spacer()
                            HStack(alignment: .center, spacing: 7) {
                                Image("waveDirectionIcon")
                                Text("3.3m/s").font(.Body2Medium)
                            }.padding(.trailing, 10)
                            Spacer()
                            HStack {
                                Image("swellDirectionIcon")
                                VStack {
                                    Text("0.2m").font(.Body2Medium)
                                    Text("3.4s").font(.CaptionMedium)
                                }
                            }
                            Spacer()
                            VStack(spacing: 0) {
                                Text("28도").font(.Body2Medium)
                                Image("waterTemperate")
                            }
                            Spacer()
                            HStack(spacing: 4) {
                                Image("starIcon")
                                Text("5점").font(.Body2Medium)
                            }
                            .cornerRadius(24)
                        }
                        .padding(.horizontal, 19)
                        .padding(.vertical, 6)
                    }
                }
            }
            .background(.white.opacity(0.5))
            .cornerRadius(24)
            .padding()
            Spacer()
        }
        .background(.teal)
        
    }
}

#Preview {
    RecentChartsView()
}
