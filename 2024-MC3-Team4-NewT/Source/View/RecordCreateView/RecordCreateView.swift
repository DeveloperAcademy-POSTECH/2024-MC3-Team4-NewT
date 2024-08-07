//
//  RecordCreateView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/5/24.

import SwiftUI
import SwiftData

struct RecordCreateView: View {
    @Environment(\.modelContext) var modelContext
    @ObservedObject var viewModel = RecordCreateViewModel()
    var cro = ChartRecordObservable()
    
    var body: some View {
        ZStack(alignment: .top){
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            VStack(spacing: 0){
                ScrollView{
                    VStack{
                        ZStack(alignment: .top){
                            Color.white
                            VStack(spacing: 0){
                                TimePickerView(viewModel: viewModel)
                                Divider()
                                    .padding(.leading)
                                ChartHeaderView(viewModel: viewModel)
                                
                                ChartView(
                                    viewModel: viewModel,
                                    observable: cro
                                )
                            }
                        }
                        .cornerRadius(24)
                        .padding(.horizontal)
                        
                        EvaluationView(
                            viewModel:viewModel
                        )
                        .frame(height: viewModel.heightSize)
                        .cornerRadius(24)
                        .padding(.horizontal)
                        
                    }
                }.scrollDisabled(viewModel.isMemo)
                    .padding(.bottom)
                
                RecordButtonView(
                    viewModel:viewModel,
                    observable: cro
                )
                
                Spacer()
            }
        }
        .navigationTitle("파도 기록")
        
    }
}

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
            viewModel.isMemo.toggle()
            
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


import SwiftUI
import SwiftData

class RecordCreateViewModel: ObservableObject {
    @Published var selectedDate = Date()
    @Published var startTime = Date()
    @Published var stopTime = Date()
    @Published var selectedScore: Int = 0
    @Published var isChartScroll: Bool = true
    @Published var isScore = 0.0
    @Published var isMemo: Bool = true
    @Published var isScoreText = ""
    @Published var memo: String = ""
    @Published var heightSize: CGFloat = 245.0
    
    let placeHolding1: String = "파도에 대한 간단한 메모를 남겨보세요."
    let placeHolding2: String = "(최대 200자)"
    let memoLimit: Int = 200
    
    var chartCounter: Int {
        var counter: Int = 1
        if stopHour > startHour {
            counter = (stopHour - startHour) + 1
        }
        return counter
    }
    
    var startHour: Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: startTime)
    }
    
    var stopHour: Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: stopTime)
    }
    
    func updateChartScroll() {
        let counter = chartCounter
        if counter > 3 {
            isChartScroll = false
        } else {
            isChartScroll = true
        }
    }
    
    func date(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateFormat = "MM월 dd일 (E)"
        return formatter.string(from: date)
    }
}
