//
//  SurfModel.swift
//  2024-MC3-Team4-NewT
//
//  Created by Yeeun on 7/26/24.
//
import Foundation
import SwiftData

@Model
final class SurfingValues {
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
    var time: String
    var surfingValues: SurfingValues
    var isHighTide: Bool
    var isLowTide: Bool
    var surfingRecordStartTime:Date?
    init(time: String, surfingValues: SurfingValues, isHighTide: Bool, isLowTide: Bool) {
        self.id = UUID()
        self.time = time
        self.surfingValues = surfingValues
        self.isHighTide = isHighTide
        self.isLowTide = isLowTide
    }
}

@Model
final class DailyWeather {
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
    var evaluationText: String
    var memo: String
    
    init(surfingStartTime: Date, surfingEndTime: Date, charts: [ChartRow], evaluationValue: Int, evaluationText: String, memo: String) {
        self.id = UUID()
        self.surfingStartTime = surfingStartTime
        self.surfingEndTime = surfingEndTime
        self.charts = charts
        self.evaluationValue = evaluationValue
        self.evaluationText = evaluationText
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
    
    init(id: UUID, waveDirection: Float? = 0.0, waveHeight: Float? = 0.0, wavePeriod: Float? = 0.0, windDirection: Float? = 0.0, windSpeed: Float? = 0.0, weather: String? = "", temperature: Float? = 0.0) {
        self.id = id
        self.waveDirection = waveDirection
        self.waveHeight = waveHeight
        self.wavePeriod = wavePeriod
        self.windDirection = windDirection
        self.windSpeed = windSpeed
        self.weather = weather
        self.temperature = temperature
    }
    init() {
        self.id = UUID()
    }
    
}


