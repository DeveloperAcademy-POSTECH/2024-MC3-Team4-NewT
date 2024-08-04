//
//  TimePickerView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/5/24.
//
import SwiftUI
import SwiftData

struct TimePickerView: View {
    @Binding var selectedDate: Date
    @Binding var startTime: Date
    @Binding var stopTime: Date
    let updateChartScroll: () -> Void
    
    var body: some View {
        VStack(spacing: 5){
            Spacer().frame(height: 13)
            HStack {
                Text("서핑 한 날짜")
                    .font(.SubheadingSemiBold)
                    .foregroundColor(Color("surfBlue"))
                Spacer()
                DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                    .labelsHidden()
                    .colorScheme(.dark)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("surfBlue"))
                    )
            }.padding(.horizontal)
            
            Divider()
                .padding(.leading)
            HStack {
                Text("시작 시간대")
                    .font(.SubheadingSemiBold)
                    .foregroundColor(Color("surfBlue"))
                Spacer()
                DatePicker("", selection: $startTime, displayedComponents: [.hourAndMinute])
                    .labelsHidden()
                    .colorScheme(.dark)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("surfBlue"))
                    )
                    .onChange(of: startTime){ newValue in
                        if(startTime>stopTime) {
                            startTime=stopTime
                        }
                        updateChartScroll()
                    }
            }.padding(.horizontal)
            
            Divider()
                .padding(.leading)
            
            HStack {
                Text("종료 시간대")
                    .font(.SubheadingSemiBold)
                    .foregroundColor(Color("surfBlue"))
                Spacer()
                DatePicker("", selection: $stopTime, displayedComponents: [.hourAndMinute])
                    .labelsHidden()
                    .colorScheme(.dark)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("surfBlue"))
                    )
                    .onChange(of: stopTime){ newValue in
                        if(startTime>stopTime) {
                            stopTime=startTime
                        }
                        updateChartScroll()
                    }
            }
            .padding(.horizontal)
        }
    }
}
