//
//  RecordButtonView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/5/24.
//

import SwiftUI
import SwiftData

struct RecordButtonView: View {
    @Query(sort:\ChartRow.time) var chartRows: [ChartRow]
    @Environment(\.modelContext) var modelContext
    @ObservedObject var viewModel : RecordCreateViewModel
    var observable : ChartRecordObservable
    
    @Environment(\.dismiss) private var dismiss // Step 1: Import the dismiss environment

    var body: some View {
        Button{
            if viewModel.isMemo {
                viewModel.heightSize = 322.0
                modelContext.insert(SurfingRecordOne(surfingStartTime: viewModel.startTime, surfingEndTime: viewModel.stopTime, charts: [], evaluationValue: Int(viewModel.isScore + 1), evaluationText: viewModel.isScoreText, memo: viewModel.memo))
            }
            else {
                viewModel.heightSize = 245.0
                viewModel.isMemo.toggle()
                modelContext.insert(SurfingRecordOne(surfingStartTime: viewModel.startTime, surfingEndTime: viewModel.stopTime, charts: [], evaluationValue: Int(viewModel.isScore + 1), evaluationText: viewModel.isScoreText, memo: viewModel.memo))
            }
            
            for aa in observable.필터된차트 {
                print(aa.time)
                let tmp2 = aa.surfingValues
                let tmp1 = SurfingValues(waveDirection: tmp2.waveDirection, waveHeight: tmp2.waveHeight, wavePeriod: tmp2.wavePeriod, windDirection: tmp2.waveDirection, windSpeed: tmp2.windSpeed, weather: "sunny", airTemperature: tmp2.airTemperature, waterTemperature: tmp2.waterTemperature)
                modelContext.insert(tmp1)
                let tmp = ChartRow(time: aa.time, surfingValues: tmp1, isHighTide: aa.isHighTide, isLowTide: aa.isLowTide)
                tmp.surfingRecordStartTime = viewModel.startTime
                modelContext.insert(tmp)
            }

            dismiss() // Step 2: Dismiss the view after the button action is successfully executed
            
        } label: {
            ZStack {
                Color("surfBlue")
                    .frame(height: 51)
                    .cornerRadius(36)
                HStack{
                    Text("기록 저장")
                        .font(.SubheadingBold)
                        .foregroundColor(Color.white)
                }
            }
            .padding(.horizontal)
            
        }
    }
}

