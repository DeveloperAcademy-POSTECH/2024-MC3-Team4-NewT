//
//  ChartViewObservable.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/3/24.
//
import SwiftData
import Observation
import SwiftUI

@Observable
class ChartRecordObservable {
    var 필터된차트: [ChartRow] = []
    
    // Filter ChartRow objects based on startTime and stopTime
    func filterChartRows(_ rows: [ChartRow], startTime: Date, stopTime: Date) -> [ChartRow] {
        let calendar = Calendar.current
        
        // Find the nearest 3-hour interval to the start time
        let startHour = calendar.component(.hour, from: startTime)
        let nearestStartHour = (startHour / 3) * 3
        let adjustedStartTime = calendar.date(bySettingHour: nearestStartHour, minute: 0, second: 0, of: startTime) ?? startTime
        
        // Filter the rows between adjustedStartTime and stopTime
        let filtered = rows.filter { row in
            if let rowDate = DateFormatterManager.shared.dateFromString(row.time) {
                return rowDate >= adjustedStartTime && rowDate <= stopTime
            }
            return false
        }
        
        // Store the filtered rows in 필터된차트
        필터된차트 = filtered
        
        return filtered
    }
    
    // Get the weather icon based on weather conditions
    func weatherIcon(for weather: String) -> String {
        switch weather.lowercased() {
            case "sunny":
                return "sun.max"
            case "cloudy":
                return "cloud"
            case "rainy":
                return "cloud.rain"
            default:
                return "questionmark"
        }
    }
}
