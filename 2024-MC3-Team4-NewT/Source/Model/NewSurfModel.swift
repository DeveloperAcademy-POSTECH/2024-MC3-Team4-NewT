////
////  NewSurfModel.swift
////  2024-MC3-Team4-NewT
////
////  Created by ram on 8/20/24.
////
//
//import Foundation
//import SwiftData
//
//@Model
//final class SurfingValues {
//    @Attribute(.unique) var id: UUID
//    var waveDirection: Float
//    var waveHeight: Float
//    var wavePeriod: Float
//    var windDirection: Float
//    var windSpeed: Float
//    var weather: String
//    var airTemperature: Float
//    var waterTemperature: Float
//    
//    init(waveDirection: Float, waveHeight: Float, wavePeriod: Float, windDirection: Float, windSpeed: Float, weather: String, airTemperature: Float, waterTemperature: Float) {
//        self.id = UUID()
//        self.waveDirection = waveDirection
//        self.waveHeight = waveHeight
//        self.wavePeriod = wavePeriod
//        self.windDirection = windDirection
//        self.windSpeed = windSpeed
//        self.weather = weather
//        self.airTemperature = airTemperature
//        self.waterTemperature = waterTemperature
//    }
//}
//
//@Model
//final class ChartRow {
//    @Attribute(.unique) var id: UUID
//    var time: String
//    var surfingValues: SurfingValues
//    var isHighTide: Bool
//    var isLowTide: Bool
//    var surfingRecordStartTime:Date?
//    init(time: String, surfingValues: SurfingValues, isHighTide: Bool, isLowTide: Bool) {
//        self.id = UUID()
//        self.time = time
//        self.surfingValues = surfingValues
//        self.isHighTide = isHighTide
//        self.isLowTide = isLowTide
//    }
//}
//
//@Model
//final class DailyWeather {
//    @Attribute(.unique) var id: UUID
//    var day: String
//    var chartCollection: [ChartRow]
//    
//    init(day: String, chartCollection: [ChartRow]) {
//        self.id = UUID()
//        self.day = day
//        self.chartCollection = chartCollection
//    }
//}
//
//@Model
//final class SurfingRecordOne {
//    @Attribute(.unique) var id: UUID
//    var surfingStartTime: Date
//    var surfingEndTime: Date
//    var charts: [ChartRow]
//    var evaluationValue: Int
//    var evaluationText: String
//    var memo: String
//    
//    init(surfingStartTime: Date, surfingEndTime: Date, charts: [ChartRow], evaluationValue: Int, evaluationText: String, memo: String) {
//        self.id = UUID()
//        self.surfingStartTime = surfingStartTime
//        self.surfingEndTime = surfingEndTime
//        self.charts = charts
//        self.evaluationValue = evaluationValue
//        self.evaluationText = evaluationText
//        self.memo = memo
//    }
//}
//
//@Model
//final class Statistics {
//    @Attribute(.unique) var id: UUID
//    var waveDirection: Float?
//    var waveHeight: Float?
//    var wavePeriod: Float?
//    var windDirection: Float?
//    var windSpeed: Float?
//    var weather: String?
//    var temperature: Float?
//    
//    init(id: UUID, waveDirection: Float? = 0.0, waveHeight: Float? = 0.0, wavePeriod: Float? = 0.0, windDirection: Float? = 0.0, windSpeed: Float? = 0.0, weather: String? = "", temperature: Float? = 0.0) {
//        self.id = id
//        self.waveDirection = waveDirection
//        self.waveHeight = waveHeight
//        self.wavePeriod = wavePeriod
//        self.windDirection = windDirection
//        self.windSpeed = windSpeed
//        self.weather = weather
//        self.temperature = temperature
//    }
//    init() {
//        self.id = UUID()
//    }
//    
//}
////
////@Model
////final class Pin{
////    @Attribute(.unique) var id: UUID
//////    var pins:[ChartRow]
//////    var pin:ChartRow
//////    var count:Int
////    var parentStartTime:String
////    init(parentStartTime:String) {
////        self.id = UUID()
//////        self.pins = pins
//////        self.count = 0
//////        self.pin = pin
////        self.parentStartTime = parentStartTime
////    }
////}
//
//
//
//struct Region: Identifiable {
//    let id = UUID()
//    let name: String
//    let items: [String]
//}
//
//let regions = [
//    Region(name: "양양", items: ["양양 물치해변", "양양 정암해변", "양양 설악해변", "양양 낙산해변", "양양 동호해변"]),
//    Region(name: "제주", items: ["제주 중문해변", "제주 이호테우해변", "제주 월정해변", "제주 사계해변"]),
//    Region(name: "부산", items: ["부산 송정해변", "부산 다대포해변"]),
//    Region(name: "고성/속초", items: ["고성 송지호해변", "고성 천진해변", "속초 속초해변"]),
//    Region(name: "강릉/동해/삼척", items: ["동해 대진해변", "강릉 금진해변", "강릉 경포해변", "삼척 용화해변"]),
//    Region(name: "포항/울산", items: ["포항 신항만해변", "포항 월포해변", "울산 진하해변"]),
//    Region(name: "서해/남해", items: ["태안 만리포해변", "고흥 남열 해돋이해변"])
//]
