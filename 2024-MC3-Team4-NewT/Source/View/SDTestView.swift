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
    @State private var selectedDate: Date = Date()

    var body: some View {
        VStack(spacing: 16) {
            // DatePicker를 사용하여 날짜 선택
            DatePicker("Select Day", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()

            Button(action: saveDailyWeather2) {
                Text("Save Daily Weather")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
    
    private func saveDailyWeather2() {
        // 선택된 날짜를 String 형식으로 변환
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: selectedDate)

        // 기본 SurfingValues 객체 생성
        let defaultSurfingValues = SurfingValues2(
            waveDirection: 180.0,
            waveHeight: 2.5,
            wavePeriod: 8.0,
            windDirection: 90.0,
            windSpeed: 15.0,
            weather: "Clear",
            airTemperature: 25.0,
            waterTemperature: 22.0
        )

        // 기본 ChartRow 객체 생성
        let defaultChartRow = ChartRow(
            day: formattedDate,
            surfingValues: defaultSurfingValues,
            isHighTide: false,
            isLowTide: false
        )
        modelContext.insert(defaultChartRow)

        // 기본 DailyWeather2 객체 생성
        let dailyWeather2 = DailyWeather2(
            day: formattedDate,
            chartCollection: [defaultChartRow] // 기본 ChartRow 배열
        )
        
        // SwiftData에 저장
        modelContext.insert(dailyWeather2)
        
        // 변경사항 저장
        do {
            try modelContext.save()
            print("Daily weather saved successfully.")
        } catch {
            print("Failed to save daily weather: \(error)")
        }
    }
}

#Preview {
    SDTestView()
}
