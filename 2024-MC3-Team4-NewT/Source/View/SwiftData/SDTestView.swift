//
//  SDTestView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/31/24.
//
import SwiftUI
import SwiftData

struct SDTestView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedDate: Date = Date() // 뷰 내부에서 관리할 State 변수
    @Query var chartRow:[ChartRow]
    var viewModel = SwiftDataObservable()
    
    var body: some View {
        VStack(spacing: 16) {
            DatePicker("Surfing Start Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(WheelDatePickerStyle())
                .padding()
            
            Button(action: {
                viewModel.selectedDate = selectedDate // 선택된 날짜를 뷰 모델로 전달
                
                
            }) {
                Text("Save")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        
    }
}

