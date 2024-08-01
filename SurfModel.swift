//
//  SurfModel.swift
//  2024-MC3-Team4-NewT
//
//  Created by Yeeun on 7/26/24.
//
import Foundation
import SwiftData

struct SurfingValues: Codable, Hashable {
    var waveDirection: Float
    var waveHeight: Float
    var wavePeriod: Float
    var windDirection: Float
    var windSpeed: Float
    var weather: String
    var airTemperature: Float
    var waterTemperature: Float
}

struct ChartRowTmp: Codable, Hashable {
    var day: Date
    var surfingValues: SurfingValues
    var isHighTide: Bool = false
    var isLowTide: Bool = false
}

@Model
final class SurfingValues2 {
    @Attribute(.unique) var id:UUID
    var waveDirection: Float
    var waveHeight: Float
    var wavePeriod: Float
    var windDirection: Float
    var windSpeed: Float
    var weather: String
    var airTemperature: Float
    var waterTemperature: Float
    init(waveDirection: Float, waveHeight: Float, wavePeriod: Float, windDirection: Float, windSpeed: Float, weather: String, airTemperature: Float, waterTemperature: Float) {
        self.id = UUID()
        self.waveDirection = waveDirection
        self.waveHeight = waveHeight
        self.wavePeriod = wavePeriod
        self.windDirection = windDirection
        self.windSpeed = windSpeed
        self.weather = weather
        self.airTemperature = airTemperature
        self.waterTemperature = waterTemperature
    }
}
@Model
final class DailyWeather: Identifiable { // 일간 기상 데이터
    @Attribute(.unique) var day: String
    var chartCollection: [ChartRowTmp]
    
    init(day: String, chartCollection: [ChartRowTmp]) {
        self.day = day
        self.chartCollection = chartCollection
    }
}

@Model
final class ChartRow {
    
    @Attribute(.unique) var id:UUID
    var day: String
    var surfingValues: SurfingValues2
    var isHighTide: Bool = false
    var isLowTide: Bool = false
    
    init(day: String, surfingValues: SurfingValues2, isHighTide: Bool, isLowTide: Bool) {
        self.id = UUID()
        self.day = day
        self.surfingValues = surfingValues
        self.isHighTide = isHighTide
        self.isLowTide = isLowTide
    }
}

@Model
final class DailyWeather2: Identifiable { // 일간 기상 데이터
    @Attribute(.unique) var id:UUID
    var day: String
    var chartCollection: [ChartRow]
    
    init(day: String, chartCollection: [ChartRow]) {
        self.id = UUID()
        self.day = day
        self.chartCollection = chartCollection
    }
}

@Model
final class SurfingRecordOne { // 단일 서핑 기록
    @Attribute(.unique) var surfingStartTime: String
    var surfingEndTime: String
    var charts: [ChartRowTmp]
    var evaluationValue: Int
    var memo: String
    
    init(surfingStartTime: String, surfingEndTime: String, charts: [ChartRowTmp], evaluationValue: Int, memo: String) {
        self.surfingStartTime = surfingStartTime
        self.surfingEndTime = surfingEndTime
        self.charts = charts
        self.evaluationValue = evaluationValue
        self.memo = memo
    }
}

@Model
final class Statistics { // 통계
    var waveDirection: Float?
    var waveHeight: Float?
    var wavePeriod: Float?
    var windDirection: Float?
    var windSpeed: Float?
    
    // 아래는 혹시 몰라 만들어놓음
    var weather: String?
    var temperature: Float?
    
    init() {
    }
}
