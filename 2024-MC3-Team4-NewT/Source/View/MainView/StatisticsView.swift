//
//  StatisticsView.swift
//  2024-MC3-Team4-NewT
//
//  Created by 김이예은 on 7/31/24.
//

import SwiftUI
import SwiftData

func FloatToDouble(_ value: Float) -> Double {
    return Double(value.rounded())
}

struct StatisticsView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var viewStatistics: Statistics
    var dummyStatistic: Statistics = Statistics(id: UUID(), waveDirection: 164.0, waveHeight: 0.16, wavePeriod: 4.75, windDirection: 234.36, windSpeed: 5.0, weather: "ra", temperature: 25.33)
    var body: some View {
        VStack(alignment: .leading, spacing:0){
            HStack(alignment: .center) {
                Text("선호하는 차트 통계")
                    .font(.Heading3Bold)
                    .foregroundColor(.white)
                Spacer()
                Button {
                    print("자세히 보기")
                } label: {
                    Image("infoIcon")
                }
            }.padding(.bottom, 24)
            
            HStack(spacing:0){
                ZStack{
                    VStack(alignment: .leading, spacing:0){
                        HStack{
                            Image("windFillIcon")
                                .foregroundColor(Color("surfBlue"))
                            
                            Text("바람")
                                .font(.Body1Bold)
                            .foregroundColor(Color("surfBlue"))                                }
                        Spacer()
                        HStack(alignment: .center, spacing:0){
                            Text("\(viewStatistics.windSpeed!, specifier: "%.1f")m/s")
                            
                                .font(.Heading1SemiBold)
                                .foregroundColor(Color("surfBlue"))
                            Spacer()
                            Image("waveDirectionIcon2")
                                .rotationEffect(.degrees(Double(FloatToDouble(viewStatistics.windDirection ?? 0))))
                                .foregroundColor(Color("surfBlue"))
                                .padding(4)
                        }
                    }.padding(12)
                        .frame(minHeight: 139)
                }
                .background(.white.opacity(0.5))
                .cornerRadius(24)
                Spacer()
                    .frame(width: 13)
                ZStack{
                    VStack(alignment: .leading, spacing:0){
                        HStack{
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
                                    .foregroundColor(Color("surfBlue"))
                                Text("\(viewStatistics.wavePeriod ?? 0.0, specifier: "%.1f")s")
                                    .font(.SubheadingSemiBold)
                                    .foregroundColor(Color("surfBlue"))
                            }
                            Spacer()
                            Image("swellDirectionIcon2")
                                .rotationEffect(.degrees(FloatToDouble(viewStatistics.waveDirection ?? 0)))
                                .foregroundColor(Color("surfBlue"))
                                .padding(4)
                        }
                        
                    }.padding(12)
                        .frame(minHeight: 139)
                }
                .background(.white.opacity(0.5))
                .cornerRadius(24)
            }
            .padding(.top)
            .padding(.bottom, 25)
            Spacer()
        }
        .onAppear {
            addDummyStatistics()
        }
        .frame(height: 202)
    }
}

extension StatisticsView {
    func addDummyStatistics() {
        let context = modelContext //modelContext 가져옴
        let dummyStatisticCharts = Statistics (id: dummyStatistic.id, waveDirection: dummyStatistic.waveDirection, waveHeight: dummyStatistic.waveHeight, wavePeriod: dummyStatistic.wavePeriod, windDirection: dummyStatistic.windDirection, windSpeed: dummyStatistic.windSpeed, weather: dummyStatistic.weather, temperature: dummyStatistic.temperature)
        context.insert(dummyStatisticCharts)
        
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
