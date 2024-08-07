//
//  DummyData.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/30/24.
//

import Foundation
import SwiftData

var dummySurfingValues =
[SurfingValuesOne(waveDirection: 164.0, waveHeight: 0.16, wavePeriod: 4.75, windDirection: 234.36, windSpeed: 5.0, weather: "ra", airTemperature: 25.33, waterTemperature: 23.5),
 SurfingValuesOne(waveDirection: 164.25, waveHeight: 0.14, wavePeriod: 4.48, windDirection: 243.03, windSpeed: 5.0, weather: "no", airTemperature: 24.45, waterTemperature: 24.5),
 SurfingValuesOne(waveDirection: 165.12, waveHeight: 0.11, wavePeriod: 4.75, windDirection: 227.92, windSpeed: 4.0, weather: "ra", airTemperature: 24.09, waterTemperature: 26.5),
 SurfingValuesOne(waveDirection: 166.12, waveHeight: 0.1, wavePeriod: 4.14, windDirection: 234.88, windSpeed: 3.0, weather: "sn", airTemperature: 27.1, waterTemperature: 25.5),
 SurfingValuesOne(waveDirection: 160.5, waveHeight: 0.09, wavePeriod: 3.2, windDirection: 196.17, windSpeed: 6.0, weather: "mix", airTemperature: 30.61, waterTemperature: 24.0),
 SurfingValuesOne(waveDirection: 150.0, waveHeight: 0.21, wavePeriod: 2.37, windDirection: 182.46, windSpeed: 8.0, weather: "ip", airTemperature: 29.8, waterTemperature: 22.5),
 SurfingValuesOne(waveDirection: 156.12, waveHeight: 0.34, wavePeriod: 3.23, windDirection: 180.19, windSpeed: 6.0, weather: "ra", airTemperature: 27.94, waterTemperature: 22.5),
 SurfingValuesOne(waveDirection: 156.25, waveHeight: 0.26, wavePeriod: 4.03, windDirection: 222.53, windSpeed: 5.0, weather: "no", airTemperature: 26.48, waterTemperature: 21.5),
 SurfingValuesOne(waveDirection: 139.38, waveHeight: 0.19, wavePeriod: 4.78, windDirection: 220.04, windSpeed: 5.0, weather: "no", airTemperature: 25.45, waterTemperature: 20.5),
 SurfingValuesOne(waveDirection: 94.81, waveHeight: 0.14, wavePeriod: 5.33, windDirection: 220.32, windSpeed: 5.0, weather: "ra", airTemperature: 24.32, waterTemperature: 18.5)
    ]

let dummyChartRows: [ChartRowTmp] = dummySurfingValues.map { surfingValue in
    ChartRowTmp(day: Date(), surfingValues: surfingValue, isHighTide: false, isLowTide: false)
}

struct Region: Identifiable {
    let id = UUID()
    let name: String
    let items: [String]
}

let regions = [
    Region(name: "양양", items: ["양양 물치해변", "양양 정암해변", "양양 설악해변", "양양 낙산해변", "양양 동호해변"]),
    Region(name: "제주", items: ["제주 중문해변", "제주 이호테우해변", "제주 월정해변", "제주 사계해변"]),
    Region(name: "부산", items: ["부산 송정해변", "부산 다대포해변"]),
    Region(name: "고성/속초", items: ["고성 송지호해변", "고성 천진해변", "속초 속초해변"]),
    Region(name: "강릉/동해/삼척", items: ["동해 대진해변", "강릉 금진해변", "강릉 경포해변", "삼척 용화해변"]),
    Region(name: "포항/울산", items: ["포항 신항만해변", "포항 월포해변", "울산 진하해변"]),
    Region(name: "서해/남해", items: ["태안 만리포해변", "고흥 남열 해돋이해변"])
]
