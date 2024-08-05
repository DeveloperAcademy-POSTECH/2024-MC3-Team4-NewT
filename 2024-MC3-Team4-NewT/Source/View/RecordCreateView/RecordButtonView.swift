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
            var 필터데이터: [ChartRow] = []

            for aa in observable.필터된차트 {
                print(aa.time)
                // 같은 modelContext에서 새로운 ChartRow 생성 후 추가
                let newChartRow = ChartRow(
                    time: aa.time,
                    surfingValues: aa.surfingValues,
                    isHighTide: aa.isHighTide,
                    isLowTide: aa.isLowTide
                )
                
                modelContext.insert(newChartRow)
                필터데이터.append(newChartRow)
                
            }

            viewModel.isMemo.toggle()

            // 같은 modelContext에서 SurfingRecordOne 생성
            let newSurfingRecord = SurfingRecordOne(
                surfingStartTime: viewModel.startTime,
                surfingEndTime: viewModel.stopTime,
                charts: [],
                evaluationValue: viewModel.selectedScore,
                memo: viewModel.memo
            )
            
            modelContext.insert(newSurfingRecord)
            for bb in 필터데이터{
                bb.surfingRecordOne = newSurfingRecord
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

