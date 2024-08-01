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
    
    // @Query를 사용하여 DailyWeather2 데이터를 가져옵니다.
    @Query private var dailyWeathers: [DailyWeather2]

    var body: some View {
        VStack(spacing: 16) {
            // DatePicker를 사용하여 날짜와 시간을 선택
            DatePicker("Surfing Start Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(WheelDatePickerStyle())  // 시간을 선택할 수 있도록 스타일 변경
                .padding()
            
            Button(action: saveOrUpdateDailyWeather2) {
                Text("Save or Update Daily Weather")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }

    private func saveOrUpdateDailyWeather2() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"  // 시간, 분, 초까지 포함하는 형식으로 설정
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul") // 한국 시간대로 설정

        let formattedDate = dateFormatter.string(from: selectedDate)
        
        // 기본 SurfingValues2 객체 생성
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
        let newChartRow = ChartRow(
            day: formattedDate,
            surfingValues: defaultSurfingValues,
            isHighTide: false,
            isLowTide: false
        )
        
        // 기존의 DailyWeather2 객체를 순환하며 확인
        var foundExisting = false
        for dailyWeather in dailyWeathers {
            if dailyWeather.day == formattedDate {
                // 기존 객체가 있으면 chartCollection에 추가
                dailyWeather.chartCollection.append(newChartRow)
                foundExisting = true
                break
            }
        }
        
        if !foundExisting {
            // 동일한 날짜의 DailyWeather2 객체가 없으면 새로운 객체 생성
            let newDailyWeather2 = DailyWeather2(
                day: formattedDate,
                chartCollection: [newChartRow]
            )
            modelContext.insert(newDailyWeather2)
        }
        
        print("Daily weather saved or updated successfully.")
    }
}

#Preview {
    SDTestView()
}
