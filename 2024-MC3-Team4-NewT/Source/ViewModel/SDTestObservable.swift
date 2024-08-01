//
//  SDTestViewModel.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/1/24.
//
import SwiftData
import Observation
import SwiftUI
@Observable
class SDTestObservable {
    
    var selectedDate: Date = Date()
    
    var dailyWeathers: [DailyWeather2] = []
    
    
    
    func loadDailyWeathers(modelContext:ModelContext) {
        // 데이터 로드를 위한 함수 (예: 초기화 또는 데이터 변경 시 호출)
        // 예시에서는 빈 데이터를 반환하거나 로드하는 로직이 여기에 포함될 수 있음
    }
    
    func saveOrUpdateDailyWeather2(modelContext:ModelContext) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        let formattedDate = dateFormatter.string(from: selectedDate)
        
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
        
        let newChartRow = ChartRow(
            day: formattedDate,
            surfingValues: defaultSurfingValues,
            isHighTide: false,
            isLowTide: false
        )
        
        var foundExisting = false
        for dailyWeather in dailyWeathers {
            if dailyWeather.day == formattedDate {
                dailyWeather.chartCollection.append(newChartRow)
                foundExisting = true
                break
            }
        }
        
        if !foundExisting {
            let newDailyWeather2 = DailyWeather2(
                day: formattedDate,
                chartCollection: [newChartRow]
            )
            modelContext.insert(newDailyWeather2)
        }
    }
}
