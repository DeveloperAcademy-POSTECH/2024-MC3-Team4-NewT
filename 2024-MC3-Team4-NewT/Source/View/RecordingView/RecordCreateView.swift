//
//  RecordCreateView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/5/24.
//

import SwiftUI

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
    let placeHolding: String = "파도에 대한 간단한 메모를 남겨보세요."
    let placeHolding1: String = "(최대 200자)"
    let memoLimit: Int = 200
    @State var heightSize: CGFloat = 245.0
    var ob = ChartRecordObservable()
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
                                TimePickerView(
                                    selectedDate: $selectedDate,
                                    startTime: $startTime,
                                    stopTime: $stopTime,
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
                                    startTime: $startTime,
                                    stopTime: $stopTime,
                                    isChartScroll: $isChartScroll, observable: ob
                                )
                            }
                        }
                        .cornerRadius(24)
                        .padding(.horizontal)
                       // 메모뷰 있던 자리
                    }
                }.scrollDisabled(isMemo)
                    .padding(.bottom)
                
                // 버튼뷰 있던 자리
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


