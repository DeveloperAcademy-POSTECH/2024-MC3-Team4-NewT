import SwiftUI
import SwiftData

func FloatToDouble(_ value: Float) -> Double {
    return Double(value.rounded())
}

struct StatisticsView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @Query private var statistics: [Statistics]
    @State private var sheetPop: Bool = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center) {
                    Text("선호하는 차트 통계")
                        .font(.Heading3Bold)
                        .foregroundColor(.white)
                    Spacer()
                    Button {
                        print("자세히 보기")
                        self.sheetPop = true
                    } label: {
                        Image("infoIcon")
                    }
                }
                .padding(.bottom, 24)

                HStack(spacing: 0) {
                    if let viewStatistics = statistics.first {
                        ZStack {
                            VStack(alignment: .leading, spacing: 0) {
                                HStack {
                                    Image("windFillIcon")
                                        .foregroundColor(Color("surfBlue"))
                                    Text("바람")
                                        .font(.Body1Bold)
                                        .foregroundColor(Color("surfBlue"))
                                }
                                Spacer()
                                HStack(alignment: .center, spacing: 0) {
                                    Text("\(viewStatistics.windSpeed ?? 0.0, specifier: "%.1f")m/s")
                                        .font(.Heading1SemiBold)
                                        .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13).opacity(0.9))
                                    Spacer()
                                    Image("waveDirectionIcon")
                                        .rotationEffect(.degrees(Double(viewStatistics.windDirection ?? 0.0)))
                                        .foregroundColor(Color("surfBlue"))
                                        .padding(4)
                                }
                            }
                            .padding(12)
                            .frame(minHeight: 139)
                        }
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(24)

                        Spacer().frame(width: 13)

                        ZStack {
                            VStack(alignment: .leading, spacing: 0) {
                                HStack {
                                    Image("waveFillIcon")
                                        .foregroundColor(Color("surfBlue"))
                                    Text("파도")
                                        .font(.Body1Bold)
                                        .foregroundColor(Color("surfBlue"))
                                    Spacer()
                                }
                                .padding(.bottom, 9)
                                Spacer()
                                HStack(alignment: .bottom) {
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text("\(viewStatistics.waveHeight ?? 0.0, specifier: "%.1f")m")
                                            .font(.Heading1SemiBold)
                                            .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13).opacity(0.9))
                                        Text("\(viewStatistics.wavePeriod ?? 0.0, specifier: "%.1f")s")
                                            .font(.SubheadingSemiBold)
                                            .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13).opacity(0.9))
                                    }
                                    Spacer()
                                    Image("swellDirectionIcon2")
                                        .rotationEffect(.degrees(Double(viewStatistics.waveDirection ?? 0.0)))
                                        .foregroundColor(Color("surfBlue"))
                                        .padding(4)
                                }
                            }
                            .padding(12)
                            .frame(minHeight: 139)
                        }
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(24)
                    } else {
                        Text("데이터가 없습니다.")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.top)
                .padding(.bottom, 25)
                Spacer()
            }
        }
        .sheet(isPresented: $sheetPop) {
            SheetView(sheetPop: $sheetPop)
                .presentationDetents([.height(450)])
                .presentationCornerRadius(21)
        }
    }
}

struct SheetView: View {
    @Binding var sheetPop: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("내가 선호하는 차트 통계")
                    .font(.Heading3Bold)
                Spacer()
                Button {
                    sheetPop = false
                } label: {
                    Image("sheetXButton")
                }
            }.padding(.horizontal, 4)
            Image("infoSheet")
        }.padding()
            .padding(.bottom, 4)
            .background(Color.white)
            .cornerRadius(24)
    }
}
