//
//  ChartView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/3/24.
//
import SwiftUI
import SwiftData

struct ChartView: View {
    @Binding var startTime: Date
    @Binding var stopTime: Date
    @Binding var isChartScroll: Bool
    @Query(sort:\ChartRow.time) var chartRows: [ChartRow]
    
    var observable : ChartRecordObservable
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 0) {
                        let filteredRows = observable.filterChartRows(chartRows, startTime: startTime, stopTime: stopTime)
                        
                        ForEach(filteredRows.indices, id: \.self) { index in
                            let row = filteredRows[index]
                            ZStack {
                                Color.white.opacity(0.8)
                                    .frame(height: 58)
                                HStack(spacing: 20) {
                                    VStack(spacing: 0) {
                                        Text(DateFormatterManager.shared.timeToHourFormatter(row.time))
                                            .font(.CaptionMedium)
                                            .foregroundColor(.black)
                                            .opacity(0.7)
                                    }
                                    HStack(spacing: 5) {
                                        Image(systemName: "paperplane")
                                            .foregroundColor(Color("iconSkyblue"))
                                        Text("\(row.surfingValues.windSpeed, specifier: "%.1f")m/s")
                                            .font(.CaptionMedium)
                                    }
                                    HStack(spacing: 5) {
                                        Image(systemName: "paperplane.fill")
                                            .foregroundColor(Color("surfBlue"))
                                        VStack(spacing: 0) {
                                            Text("\(row.surfingValues.waveHeight, specifier: "%.1f")m")
                                                .font(.CaptionMedium)
                                            Text("\(row.surfingValues.wavePeriod, specifier: "%.1f")s")
                                                .font(.CaptionMedium)
                                        }
                                    }
                                    VStack(spacing: 0) {
                                        Text("\(row.surfingValues.waterTemperature, specifier: "%.1f")°C")
                                            .font(.Body2Medium)
                                        Image(systemName: "water.waves")
                                            .foregroundColor(Color("iconPurple"))
                                    }
                                    HStack(spacing: 5) {
                                        Image(systemName: observable.weatherIcon(for: row.surfingValues.weather))
                                            .foregroundColor(.gray)
                                        Text("\(row.surfingValues.airTemperature, specifier: "%.1f")°C")
                                            .font(.Body2Medium)
                                    }
                                }
                                if (filteredRows.count > 3) {
                                    if (index < filteredRows.count - 1) {
                                        Divider()
                                            .background(Color("surfBlue"))
                                            .padding(.top, 58)
                                    }
                                } else {
                                    if (index == 0 || index == 1) {
                                        Divider()
                                            .background(Color("surfBlue"))
                                            .padding(.top, 58)
                                    }
                                }
                            }
                        }
                    }
                }
                .scrollDisabled(isChartScroll)
            }
        }
        .frame(height: 174)
    }
}
