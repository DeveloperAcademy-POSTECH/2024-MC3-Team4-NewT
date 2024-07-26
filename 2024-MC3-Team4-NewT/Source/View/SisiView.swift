//
//  SisiView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/21/24.
//

import SwiftUI

struct SisiView: View {
    @State var selectedDate = Date() //날짜
    @State var startTime = Date() //시작시간
    @State var stopTime = Date() //종료시간
    @State private var selectedScore: Int = 3 //별점 점수

    var body: some View {
        VStack(spacing: 15){
            
                Section { // 날짜 선택 섹션
                    VStack{
                        DatePicker(
                            "서핑 한 날짜",
                            selection: $selectedDate,
                            displayedComponents: [.date]
                        )
                        Divider()
                        
                        DatePicker(
                            "시작 시간",
                            selection: $startTime,
                            displayedComponents: [.hourAndMinute]
                        )
                        Divider()
                        
                        DatePicker(
                            "종료 시간",
                            selection: $stopTime,
                            displayedComponents: [.hourAndMinute]
                        )
                    }
                    .padding(10)
                    .frame(width: 370)
                    .background(Color(.systemGroupedBackground))
                    .cornerRadius(15)
                }
                
                
            Section { // 차트 섹션
                VStack(spacing:15){
                    Text(selectedDate, formatter: dateFormatter)
                        .font(.title3)
                        .bold()
                    Divider()
                    
                    HStack(spacing: 40){
                        Text("시간")
                        Text("바람")
                        Text("파도")
                        Text("수온")
                        Text("날씨")
                    }
                    Divider()
                    
                    if(chartCounter>3){
                        ScrollView{
                            ForEach(0..<chartCounter, id: \.self) { index in
                                Text("\(index + startHour)시 -> 차트")
                                    .padding()
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(8)
                            }
                        }.frame(height: 187) //차트 3개일때랑 값 똑같게 해야함.
                    }
                    
                    else {
                        ForEach(0..<chartCounter, id: \.self) { index in
                            Text("\(index + startHour)시 -> 차트")
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                    
//                    Text("시간 차이: \(chartCounter)시간")
//                                .font(.title)
//                    Text("startHoure: \(startHour)시")
//                                .font(.title)
//                    Text("stoptHoure: \(stopHour)시")
//                                .font(.title)
                    
                }
                .padding(10)
                .frame(width: 370)
                .background(Color(.systemGroupedBackground))
                .cornerRadius(15)
            }
            
            Section{ // 평가 섹션
                VStack{
                    Text("오늘의 서핑은 어떠셨나요?")
                        .font(.title3)
                        .bold()
                    HStack{
                        ForEach(1..<6) { index in
                            Button {
                                selectedScore = index
                            } label: {
                                Circle()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(selectedScore == index ? .blue : .gray) // 인덱스에 따라 색상 변경
                            }
                        }
                        
                    }
                }
                .padding(10)
                    .frame(width: 370)
                    .background(Color(.systemGroupedBackground))
                    .cornerRadius(15)

            }
            
        }.navigationTitle("차트기록")
        
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "ko-KR")
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter
       }
    
    var startHour: Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: startTime)
    }
    var stopHour: Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: stopTime)
    }
    
    var chartCounter: Int {
        return (stopHour - startHour)+1
        //+1 하는 이유는 11:20~ 14:30일 경우  11,12,13,14시 총 4개를 보여줘야하기 때문
    }
    
}

#Preview {
    SisiView()
}
