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
    @Environment(\.modelContext) var modelContext
    @ObservedObject var viewModel: RecordCreateViewModel
    var observable: ChartRecordObservable

    var body: some View {
        Button {
            var filteredCharts: [ChartRow] = []
            
            for item1 in observable.필터된차트 {
                let newChartRow = ChartRow(
                    time: item1.time,
                    surfingValues: item1.surfingValues,
                    isHighTide: item1.isHighTide,
                    isLowTide: item1.isLowTide
                )
                modelContext.insert(newChartRow)
                filteredCharts.append(newChartRow)
                
            }
        
            viewModel.isMemo.toggle()
            if let aa = filteredCharts.first{
                let newSurfingRecord = SurfingRecordOne(
                    surfingStartTime: viewModel.startTime,
                    surfingEndTime: viewModel.stopTime,
                    evaluationValue: viewModel.selectedScore+1,
                    evaluationText: viewModel.isScoreText,
                    memo: viewModel.memo,
                    firstCharts: aa)
                modelContext.insert(newSurfingRecord)
                for item2 in filteredCharts{
                    item2.surfingRecordOne = newSurfingRecord
                }
                
            }
            else{
                print("filteredCharts.first에서 nil로 터짐")
            }
            
//            try modelContext.save()

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
}

