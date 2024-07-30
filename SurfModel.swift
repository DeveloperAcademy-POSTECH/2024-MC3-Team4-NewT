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
final class ChartRow {
    @Attribute(.unique) var day: Date
    var surfingValues: SurfingValues
    var isHighTide: Bool
    var isLowTide: Bool

    init(day: Date, surfingValues: SurfingValues, isHighTide: Bool, isLowTide: Bool) {
        self.day = day
        self.surfingValues = surfingValues
        self.isHighTide = false
        self.isLowTide = false
    }
}

@Model
final class DailyWeather {
    @Attribute(.unique) var day: String
    var chartCollection: [ChartRowTmp]

    init(day: String, chartCollection: [ChartRowTmp]) {
        self.day = day
        self.chartCollection = chartCollection
    }
}

@Model
final class SurfingRecordOne {
    @Attribute(.unique) var surfingStartTime: Date
    var surfingEndTime: Date
    var charts: [ChartRow]
    var evaluationValue: Int
    var memo: String

    init(surfingStartTime: Date, surfingEndTime: Date, charts: [ChartRow], evaluationValue: Int, memo: String) {
        self.surfingStartTime = surfingStartTime
        self.surfingEndTime = surfingEndTime
        self.charts = charts
        self.evaluationValue = evaluationValue
        self.memo = memo
    }
}

@Model
final class Statistics {
    var waveDirection: Float?
    var waveHeight: Float?
    var wavePeriod: Float?
    var windDirection: Float?
    var windSpeed: Float?

    // 아래는 혹시 몰라 만들어놓음
    var weather: String?
    var temperature: Float?

    init() { }
}
