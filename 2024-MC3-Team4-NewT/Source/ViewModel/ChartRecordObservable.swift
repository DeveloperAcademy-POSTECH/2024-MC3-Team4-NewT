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
    
    // startTime과 stopTime을 기준으로 ChartRow 객체들을 필터링합니다.
    func filterChartRows(_ rows: [ChartRow], startTime: Date, stopTime: Date) -> [ChartRow] {
        let calendar = Calendar.current
        
        // 시작 시간에 가장 가까운 3시간 간격을 찾습니다.
        let startHour = calendar.component(.hour, from: startTime)
        let nearestStartHour = (startHour / 3) * 3
        let adjustedStartTime = calendar.date(bySettingHour: nearestStartHour, minute: 0, second: 0, of: startTime) ?? startTime
        
        // adjustedStartTime과 stopTime 사이에 있는 행들을 필터링합니다.
        let filtered = rows.filter { row in
            if let rowDate = DateFormatterManager.shared.dateFromString(row.time) {
                return rowDate >= adjustedStartTime && rowDate <= stopTime
            }
            return false
        }
        
        // 필터링된 행들을 필터된차트에 저장합니다.
        필터된차트 = filtered
        
        return filtered
    }
    
    // 날씨 조건에 따라 날씨 아이콘을 가져옵니다.
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
