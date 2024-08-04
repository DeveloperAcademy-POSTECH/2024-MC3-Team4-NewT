//
//  TimePickerView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/5/24.
//
import SwiftUI
import SwiftData

struct TimePickerView: View {
    @ObservedObject var viewModel : RecordCreateViewModel
    
    var body: some View {
        VStack(spacing: 5){
            Spacer().frame(height: 13)
            HStack {
                Text("서핑 한 날짜")
                    .font(.SubheadingSemiBold)
                    .foregroundColor(Color("surfBlue"))
                Spacer()
                DatePicker("", selection: $viewModel.selectedDate, displayedComponents: [.date])
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
                DatePicker("", selection: $viewModel.startTime, displayedComponents: [.hourAndMinute])
                    .labelsHidden()
                    .colorScheme(.dark)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("surfBlue"))
                    )
                    .onChange(of: viewModel.startTime) {
                        if viewModel.startTime > viewModel.stopTime {
                            viewModel.startTime = viewModel.stopTime
                        }
                        viewModel.updateChartScroll()
                    }
            }.padding(.horizontal)
            
            Divider()
                .padding(.leading)
            
            HStack {
                Text("종료 시간대")
                    .font(.SubheadingSemiBold)
                    .foregroundColor(Color("surfBlue"))
                Spacer()
                DatePicker("", selection: $viewModel.stopTime, displayedComponents: [.hourAndMinute])
                    .labelsHidden()
                    .colorScheme(.dark)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("surfBlue"))
                    )
                    .onChange(of: viewModel.stopTime) {
                        if viewModel.startTime > viewModel.stopTime {
                            viewModel.stopTime = viewModel.startTime
                        }
                        viewModel.updateChartScroll()
                    }
            }
            .padding(.horizontal)
        }
    }
}
