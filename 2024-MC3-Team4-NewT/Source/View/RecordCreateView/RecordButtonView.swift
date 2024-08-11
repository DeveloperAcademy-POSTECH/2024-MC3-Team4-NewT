//
//  RecordButtonView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/5/24.
//

import SwiftUI
import SwiftData

struct RecordButtonView: View {
    @Query(sort: \ChartRow.time) var chartRows: [ChartRow]
    @Query(sort: \SurfingRecordOne.surfingStartTime) var surfingRecords: [SurfingRecordOne]
    @Environment(\.modelContext) var modelContext
    @ObservedObject var viewModel: RecordCreateViewModel
    var observable: ChartRecordObservable
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button {
            let evaluationValue = Int(viewModel.isScore + 1)
            let record = SurfingRecordOne(surfingStartTime: viewModel.startTime, surfingEndTime: viewModel.stopTime, charts: [], evaluationValue: evaluationValue, evaluationText: viewModel.isScoreText, memo: viewModel.memo)
            
            if viewModel.isMemo {
                viewModel.heightSize = 322.0
            } else {
                viewModel.heightSize = 245.0
                viewModel.isMemo.toggle()
            }
            
            modelContext.insert(record)
            
            for aa in observable.필터된차트 {
                let tmp2 = aa.surfingValues
                let tmp1 = SurfingValues(waveDirection: tmp2.waveDirection, waveHeight: tmp2.waveHeight, wavePeriod: tmp2.wavePeriod, windDirection: tmp2.waveDirection, windSpeed: tmp2.windSpeed, weather: tmp2.weather, airTemperature: tmp2.airTemperature, waterTemperature: tmp2.waterTemperature)
                modelContext.insert(tmp1)
                let tmp = ChartRow(time: aa.time, surfingValues: tmp1, isHighTide: aa.isHighTide, isLowTide: aa.isLowTide)
                tmp.surfingRecordStartTime = viewModel.startTime
                modelContext.insert(tmp)
            }
            
            updateStatistics() // Update statistics after inserting records
            
            dismiss()
        } label: {
            ZStack {
                Color("surfBlue")
                    .frame(height: 51)
                    .cornerRadius(36)
                HStack {
                    Text("기록 저장")
                        .font(.SubheadingBold)
                        .foregroundColor(Color.white)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func updateStatistics() {
        // Fetch all ChartRows and SurfingRecords
        let allChartRows = chartRows
        let allSurfingRecords = surfingRecords
        
        // Filter SurfingRecords with evaluationValue >= 3
        let relevantRecords = allSurfingRecords.filter { $0.evaluationValue >= 3 }
        
        guard !relevantRecords.isEmpty else { return }
        
        var totalWaveDirection: Double = 0.0
        var totalWaveHeight: Double = 0.0
        var totalWavePeriod: Double = 0.0
        var totalWindDirection: Double = 0.0
        var totalWindSpeed: Double = 0.0
        var count: Double = 0.0
        
        for record in relevantRecords {
            let recordChartRows = observable.filterChartRows(allChartRows, startTime: record.surfingStartTime, stopTime: record.surfingEndTime)
            
            for chartRow in recordChartRows {
                totalWaveDirection += Double(chartRow.surfingValues.waveDirection)
                totalWaveHeight += Double(chartRow.surfingValues.waveHeight)
                totalWavePeriod += Double(chartRow.surfingValues.wavePeriod)
                totalWindDirection += Double(chartRow.surfingValues.windDirection)
                totalWindSpeed += Double(chartRow.surfingValues.windSpeed)
                count += 1.0
            }
        }
        
        guard count > 0 else { return }
        
        let averageWaveDirection = Float(totalWaveDirection / count)
        let averageWaveHeight = Float(totalWaveHeight / count)
        let averageWavePeriod = Float(totalWavePeriod / count)
        let averageWindDirection = Float(totalWindDirection / count)
        let averageWindSpeed = Float(totalWindSpeed / count)
        
        // Fetch the existing Statistics or create a new one if it doesn't exist
        let descriptor = FetchDescriptor<Statistics>()
        let statistics: Statistics
        if let fetchedStatistics = try? modelContext.fetch(descriptor).first {
            statistics = fetchedStatistics
        } else {
            statistics = Statistics()
            modelContext.insert(statistics)
        }
        
        statistics.waveDirection = averageWaveDirection
        statistics.waveHeight = averageWaveHeight
        statistics.wavePeriod = averageWavePeriod
        statistics.windDirection = averageWindDirection
        statistics.windSpeed = averageWindSpeed
        
        do {
            try modelContext.save()
        } catch {
            print("Failed to save statistics: \(error)")
        }
    }
}
