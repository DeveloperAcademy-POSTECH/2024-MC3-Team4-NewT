//
//  OldModel.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/5/24.
//
import SwiftData
import SwiftUI
import Foundation
//MARK: 여기서부턴 코드 초안 옮겨놓은 것
struct SurfingValuesOne: Codable, Hashable {
    var waveDirection: Float
    var waveHeight: Float
    var wavePeriod: Float
    var windDirection: Float
    var windSpeed: Float
    var weather: String
    var airTemperature: Float
    var waterTemperature: Float
}

struct ChartRowTmp: Codable, Hashable, Identifiable{
    let id = UUID()
    var day: Date
    var surfingValues: SurfingValuesOne
    var isHighTide: Bool = false
    var isLowTide: Bool = false
}


@Model
final class DailyWeatherOld{ // 일간 기상 데이터
    @Attribute(.unique) var day: String
    var chartCollection: [ChartRowTmp]
    
    init(day: String, chartCollection: [ChartRowTmp]) {
        self.day = day
        self.chartCollection = chartCollection
    }
}
enum ModelType: String, CaseIterable {
    case surfingValues2 = "SurfingValues2"
    case chartRow = "ChartRow"
    case dailyWeather2 = "DailyWeather2"
    case surfingRecordOne = "SurfingRecordOne"
    case statistics = "Statistics"
}

