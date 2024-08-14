//
//  RecordCreateViewModel.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/5/24.
//


import SwiftUI
import SwiftData

class RecordCreateViewModel: ObservableObject {
    @Published var selectedDate = Date()
    @Published var startTime = Date()
    @Published var stopTime = Date()
    @Published var selectedScore: Int = 0
    @Published var isChartScroll: Bool = true
    @Published var isScore = 0.0
    @Published var isMemo: Bool = true
    @Published var isScoreText = ""
    @Published var memo: String = ""
    @Published var heightSize: CGFloat = 245.0
    
    var placeHolding1: String = "파도에 대한 간단한 메모를 남겨보세요."
    var placeHolding2: String = "(최대 200자)"
    let memoLimit: Int = 200
    
    var chartCounter: Int {
        var counter: Int = 1
        if stopHour > startHour {
            counter = (stopHour - startHour) + 1
        }
        return counter
    }
    
    var startHour: Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: startTime)
    }
    
    var stopHour: Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: stopTime)
    }
    
    func updateChartScroll() {
        let counter = chartCounter
        if counter > 3 {
            isChartScroll = false
        } else {
            isChartScroll = true
        }
    }
    
    func resetData() {
            // Reset all properties to their initial values
            selectedDate = Date()
            startTime = Date()
            stopTime = Date()
            selectedScore = 0
            isChartScroll = true
            isScore = 0.0
            isMemo = true
            isScoreText = ""
            memo = ""
            heightSize = 245.0
        }
}
