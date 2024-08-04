//
//  SDCheckView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/1/24.
//
import SwiftUI
import SwiftData


struct SDCheckView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedModel: ModelType = .surfingValues2
    
    @Query private var surfingValues2Data: [SurfingValues]
    @Query(sort:\ChartRow.time) private var chartRowData: [ChartRow]
    @Query private var dailyWeather2Data: [DailyWeather]
    @Query private var surfingRecordOneData: [SurfingRecordOne]
    @Query private var statisticsData: [Statistics]
    
    var body: some View {
        VStack {
            Picker("Select Model", selection: $selectedModel) {
                ForEach(ModelType.allCases, id: \.self) { model in
                    Text(model.rawValue).tag(model)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            List {
                switch selectedModel {
                    case .surfingValues2:
                        ForEach(surfingValues2Data, id: \.id) { item in
                            VStack(alignment: .leading) {
                                Text("Wave Direction: \(item.waveDirection)")
                                Text("Wave Height: \(item.waveHeight)")
                                Text("Weather: \(item.weather)")
                                Text("Air Temperature: \(item.airTemperature)")
                            }
                        }
                        
                    case .chartRow:
                        ForEach(chartRowData, id: \.id) { item in
                            VStack(alignment: .leading) {
                                Text("Day: \(item.time)")
                                Text("Is High Tide: \(item.isHighTide ? "Yes" : "No")")
                                Text("Is Low Tide: \(item.isLowTide ? "Yes" : "No")")
                                Text("Wave Direction: \(item.surfingValues.waveDirection)")
                            }
                        }
                        
                    case .dailyWeather2:
                        ForEach(dailyWeather2Data, id: \.id) { item in
                            VStack(alignment: .leading) {
                                Text("Day: \(item.day)")
                                Text("Number of Charts: \(item.chartCollection.count)")
                            }
                        }
                        
                    case .surfingRecordOne:
                        ForEach(surfingRecordOneData, id: \.id) { item in
                            VStack(alignment: .leading) {
                                Text("Start Time: \(item.surfingStartTime)")
                                Text("End Time: \(item.surfingEndTime)")
                                Text("Evaluation: \(item.evaluationValue)")
                                Text("Memo: \(item.memo)")
                            }
                        }
                        
                    case .statistics:
                        ForEach(statisticsData, id: \.id) { item in
                            VStack(alignment: .leading) {
                                Text("Wave Direction: \(item.waveDirection ?? 0)")
                                Text("Temperature: \(item.temperature ?? 0)")
                            }
                        }
                }
            }
        }
    }
}
