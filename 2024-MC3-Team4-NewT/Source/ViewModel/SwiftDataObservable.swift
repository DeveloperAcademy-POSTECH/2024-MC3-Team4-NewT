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
    var dailyWeathers: [DailyWeather] = []
    
    // SurfingValues2 전체 모델을 인자로 받아 생성하는 함수
    func createSurfingValues2(modelContext: ModelContext, surfingValues: SurfingValues) {
        modelContext.insert(surfingValues)
    }
    
    // ChartRow 전체 모델을 인자로 받아 생성하는 함수
    func createChartRow(modelContext: ModelContext, chartRow: ChartRow) {
        modelContext.insert(chartRow)
    }
    
    // DailyWeather2 전체 모델을 인자로 받아 생성하는 함수
    func createDailyWeather2(modelContext: ModelContext, dailyWeather: DailyWeather) {
        modelContext.insert(dailyWeather)
    }
    
    // SurfingRecordOne 전체 모델을 인자로 받아 생성하는 함수
    func createSurfingRecordOne(modelContext: ModelContext, surfingRecord: SurfingRecordOne) {
        modelContext.insert(surfingRecord)
    }
    
    // Statistics 전체 모델을 인자로 받아 생성하는 함수
    func createStatistics(modelContext: ModelContext, statistics: Statistics) {
        modelContext.insert(statistics)
    }
}
