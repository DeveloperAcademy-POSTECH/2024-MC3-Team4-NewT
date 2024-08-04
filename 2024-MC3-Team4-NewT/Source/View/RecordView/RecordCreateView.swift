//
//  RecordCreateView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/5/24.

import SwiftUI
import SwiftData

struct RecordCreateView: View {
    @Environment(\.modelContext) var modelContext
    @State var selectedDate = Date()
    @State var startTime = Date()
    @State var stopTime = Date()
    @State var selectedScore: Int = 0
    @State var isChartScroll: Bool = true
    @State var isScore = 0.0
    @State var isMemo: Bool = true
    @State var memo: String = ""
    let placeHolding1: String = "파도에 대한 간단한 메모를 남겨보세요."
    let placeHolding2: String = "(최대 200자)"
    let memoLimit: Int = 200
    @State var heightSize: CGFloat = 245.0
    var ob = ChartRecordObservable()
    @ObservedObject var viewModel = RecordCreateViewModel()
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
                                TimePickerView(viewModel: viewModel,
                                               updateChartScroll: updateChartScroll
                                )
                                
                                Divider()
                                    .padding(.leading)
                                Text(date(from: selectedDate))
                                    .font(.SubheadingBold)
                                    .foregroundStyle(Color("surfBlue"))
                                    .padding(.vertical, 8)
                                ZStack{
                                    Rectangle()
                                        .frame(height: 20)
                                        .foregroundColor(Color(.systemGroupedBackground))
                                    HStack(spacing: 50){
                                        Text("시간")
                                        Text("바람")
                                        Text("파도")
                                        Text("수온")
                                        Text("날씨")
                                    }
                                    .font(.CaptionMedium)
                                    .foregroundColor(Color(.black).opacity(0.5))
                                }
                                ChartView(
                                    viewModel: viewModel,  // 여기서 viewModel을 전달합니다.
                                    isChartScroll: $viewModel.isChartScroll,
                                    observable: ob
                                )
                                
                            }
                        }
                        .cornerRadius(24)
                        .padding(.horizontal)
                        
                        // Start
                        EvaluationView(
                            selectedScore: $selectedScore,
                            isScore: $isScore,
                            isMemo: $isMemo,
                            memo: $memo,
                            heightSize: $heightSize,
                            placeHolding: placeHolding1,
                            placeHolding1: placeHolding2,
                            memoLimit: memoLimit
                        )
                        .frame(height: heightSize)
                        .cornerRadius(24)
                        .padding(.horizontal)
                        // End
                    }
                }.scrollDisabled(isMemo)
                    .padding(.bottom)
                
                // Start: RecordButtonView
                RecordButtonView(
                    isMemo: $isMemo,
                    heightSize: $heightSize,
                    startTime: startTime,
                    stopTime: stopTime,
                    memo: memo,
                    memoLimit: memoLimit
                )
                // End: RecordButtonView
                
                Spacer()
                
            }
        }
        .navigationTitle("파도 기록")
        
    }
    
    func date(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateFormat = "MM월 dd일 (E)"
        return formatter.string(from: date)
    }
    
    func updateChartScroll() {
        let counter = chartCounter
        if counter > 3 {
            isChartScroll = false
        } else {
            isChartScroll = true
        }
    }
    
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
}

