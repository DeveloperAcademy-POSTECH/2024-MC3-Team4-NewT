//
//  SDTestViewModel.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/1/24.
//
import SwiftData
import Observation
import SwiftUI

@Observable
class SwiftDataObservable {
    
    var selectedDate: Date = Date()
    var dailyWeathers: [OldDailyWeather] = []
    
    // SurfingValues2 전체 모델을 인자로 받아 생성하는 함수
    func createSurfingValues2(modelContext: ModelContext, surfingValues: OldSurfingValues) {
        modelContext.insert(surfingValues)
    }
    
    // ChartRow 전체 모델을 인자로 받아 생성하는 함수
    func createChartRow(modelContext: ModelContext, chartRow: OldChartRow) {
        modelContext.insert(chartRow)
    }
    
    // DailyWeather2 전체 모델을 인자로 받아 생성하는 함수
    func createDailyWeather2(modelContext: ModelContext, dailyWeather: OldDailyWeather) {
        modelContext.insert(dailyWeather)
    }
    
    // SurfingRecordOne 전체 모델을 인자로 받아 생성하는 함수
    func createSurfingRecordOne(modelContext: ModelContext, surfingRecord: OldSurfingRecordOne) {
        modelContext.insert(surfingRecord)
    }
    
    // Statistics 전체 모델을 인자로 받아 생성하는 함수
    func createStatistics(modelContext: ModelContext, statistics: OldStatistics) {
        modelContext.insert(statistics)
    }
}
