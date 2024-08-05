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
    
    var body: some View {
        Button{
            for aa in observable.필터된차트{
                print(aa.time)
            }
            
            
//            let filteredRows = observable.filterChartRows(
//                chartRows,
//                startTime: viewModel.startTime,
//                stopTime: viewModel.stopTime
//            )
//
//            let calendar = Calendar.current
//                
//                // 시작 시간에 가장 가까운 3시간 간격을 찾습니다.
//            let startHour = calendar.component(.hour, from: viewModel.startTime)
//                let nearestStartHour = (startHour / 3) * 3
//            let adjustedStartTime = calendar.date(bySettingHour: nearestStartHour, minute: 0, second: 0, of: viewModel.startTime) ?? viewModel.startTime
//                
//                // Predicate를 정의하여 필터링 조건을 작성합니다.
//                let predicate = #Predicate<ChartRow> { row in
//                    if let rowDate = DateFormatterManager.shared.dateFromString(row.time) {
//                        rowDate >= adjustedStartTime && rowDate <= viewModel.stopTime
//                    }
//                    return false
//                }

//                // Predicate를 사용하여 행들을 필터링합니다.
//                let filtered = rows.filter { row in
//                    predicate.evaluate(with: row)
//                }
                
            

            viewModel.isMemo.toggle()

//            modelContext.insert(
//                SurfingRecordOne(
//                    surfingStartTime: viewModel.startTime,
//                    surfingEndTime: viewModel.stopTime,
//                    charts: [],
//                    evaluationValue: viewModel.memoLimit,
//                    memo: viewModel.memo))
            
//            if viewModel.isMemo {
//                viewModel.heightSize = 245.0
//            }
//            else {
//                viewModel.heightSize = 322.0
//            }
            
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

