//
//  SurfModel.swift
//  2024-MC3-Team4-NewT
//
//  Created by Yeeun on 7/26/24.
//
import Foundation
import SwiftData

@Model
final class SurfingValues2 {
    @Attribute(.unique) var id: UUID
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
final class ChartRow {
    @Attribute(.unique) var id: UUID
    var day: String
    var surfingValues: SurfingValues2
    var isHighTide: Bool
    var isLowTide: Bool
    
    init(day: String, surfingValues: SurfingValues2, isHighTide: Bool, isLowTide: Bool) {
        self.id = UUID()
        self.day = day
        self.surfingValues = surfingValues
        self.isHighTide = isHighTide
        self.isLowTide = isLowTide
    }
}

@Model
final class DailyWeather2 {
    @Attribute(.unique) var id: UUID
    var day: String
    var chartCollection: [ChartRow]
    
    init(day: String, chartCollection: [ChartRow]) {
        self.id = UUID()
        self.day = day
        self.chartCollection = chartCollection
    }
}

@Model
final class SurfingRecordOne {
    @Attribute(.unique) var id: UUID
    var surfingStartTime: Date
    var surfingEndTime: Date
    var charts: [ChartRow]
    var evaluationValue: Int
    var memo: String
    
    init(surfingStartTime: Date, surfingEndTime: Date, charts: [ChartRow], evaluationValue: Int, memo: String) {
        self.id = UUID()
        self.surfingStartTime = surfingStartTime
        self.surfingEndTime = surfingEndTime
        self.charts = charts
        self.evaluationValue = evaluationValue
        self.memo = memo
    }
}

@Model
final class Statistics {
    @Attribute(.unique) var id: UUID
    var waveDirection: Float?
    var waveHeight: Float?
    var wavePeriod: Float?
    var windDirection: Float?
    var windSpeed: Float?
    var weather: String?
    var temperature: Float?
    
    init(waveDirection: Float? = nil, waveHeight: Float? = nil, wavePeriod: Float? = nil, windDirection: Float? = nil, windSpeed: Float? = nil, weather: String? = nil, temperature: Float? = nil) {
        self.waveDirection = 0.0
        self.waveHeight = 0.0
        self.wavePeriod = 0.0
        self.windDirection = 0.0
        self.windSpeed = 0.0
        self.weather = ""
        self.temperature = 0.0
    init() {
        self.id = UUID()

    }
}
