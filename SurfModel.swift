//
//  SurfModel.swift
//  2024-MC3-Team4-NewT
//
//  Created by Yeeun on 7/26/24.
//

import Foundation
import SwiftData

@Model
final class ChartRow: Identifiable{
    @Attribute(.unique) var day: Date
    var surfingValues: SurfingValues
    var isHighTide: Bool?
    var isLowTide: Bool?
    
    init(day: Date = Date(), surfingValues: SurfingValues = SurfingValues(waveDirection: 0.0, waveHeight: 0.0, wavePeriod: 0.0, windDirection: 0.0, windSpeed: 0.0, weather: "", airTemperature: 0.0, waterTemperature: 0.0), isHighTide: Bool? = nil, isLowTide: Bool? = nil) {
            self.day = day
            self.surfingValues = surfingValues
            self.isHighTide = isHighTide
            self.isLowTide = isLowTide
        }
}

struct SurfingValues: Codable {
    var waveDirection: Float
    var waveHeight: Float
    var wavePeriod: Float
    var windDirection: Float
    var windSpeed: Float
    var weather: String
    var airTemperature: Float
    var waterTemperature: Float
}

var dummySurfingValues =
[SurfingValues(waveDirection: 164.0, waveHeight: 0.16, wavePeriod: 4.75, windDirection: 234.36, windSpeed: 5.0, weather: "ra", airTemperature: 25.33, waterTemperature: 23.5),
 SurfingValues(waveDirection: 164.25, waveHeight: 0.14, wavePeriod: 4.48, windDirection: 243.03, windSpeed: 5.0, weather: "no", airTemperature: 24.45, waterTemperature: 24.5),
 SurfingValues(waveDirection: 165.12, waveHeight: 0.11, wavePeriod: 4.75, windDirection: 227.92, windSpeed: 4.0, weather: "ra", airTemperature: 24.09, waterTemperature: 26.5),
 SurfingValues(waveDirection: 166.12, waveHeight: 0.1, wavePeriod: 4.14, windDirection: 234.88, windSpeed: 3.0, weather: "sn", airTemperature: 27.1, waterTemperature: 25.5),
 SurfingValues(waveDirection: 160.5, waveHeight: 0.09, wavePeriod: 3.2, windDirection: 196.17, windSpeed: 6.0, weather: "mix", airTemperature: 30.61, waterTemperature: 24.0),
 SurfingValues(waveDirection: 150.0, waveHeight: 0.21, wavePeriod: 2.37, windDirection: 182.46, windSpeed: 8.0, weather: "ip", airTemperature: 29.8, waterTemperature: 22.5),
 SurfingValues(waveDirection: 156.12, waveHeight: 0.34, wavePeriod: 3.23, windDirection: 180.19, windSpeed: 6.0, weather: "ra", airTemperature: 27.94, waterTemperature: 22.5),
 SurfingValues(waveDirection: 156.25, waveHeight: 0.26, wavePeriod: 4.03, windDirection: 222.53, windSpeed: 5.0, weather: "no", airTemperature: 26.48, waterTemperature: 21.5),
 SurfingValues(waveDirection: 139.38, waveHeight: 0.19, wavePeriod: 4.78, windDirection: 220.04, windSpeed: 5.0, weather: "no", airTemperature: 25.45, waterTemperature: 20.5),
 SurfingValues(waveDirection: 94.81, waveHeight: 0.14, wavePeriod: 5.33, windDirection: 220.32, windSpeed: 5.0, weather: "ra", airTemperature: 24.32, waterTemperature: 18.5)
    ]

let dummyChartRows: [ChartRow] = dummySurfingValues.map { surfingValue in
    ChartRow(surfingValues: surfingValue)
}

