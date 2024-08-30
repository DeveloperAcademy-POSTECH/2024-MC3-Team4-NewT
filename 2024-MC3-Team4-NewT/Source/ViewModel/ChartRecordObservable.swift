//
//  ChartViewObservable.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/3/24.
//
import SwiftData
import Observation
import SwiftUI

@Observable
class ChartRecordObservable {
    // 필터링된 차트 행들을 저장하는 배열
    var 필터된차트: [OldChartRow] = []
    
    // 주어진 차트 배열에서 특정 기록과 관련된 차트 행을 필터링하는 메서드
    func test(charts: [OldChartRow], recordOne: OldSurfingRecordOne) -> [OldChartRow] {
        var 필터된데이터: [OldChartRow] = []
        
        // 모든 차트 행을 순회하며, 주어진 기록의 시작 시간과 일치하는 차트 행을 찾음
        for chartRow in charts {
            if let associatedRecord = chartRow.surfingRecordStartTime {
                if associatedRecord == recordOne.surfingStartTime {
                    // 일치하는 경우 필터된 데이터에 추가
                    필터된데이터.append(chartRow)
                }
            }
        }
        
        // 필터링된 데이터 반환
        return 필터된데이터
    }

    // 차트 행들을 시작 시간과 종료 시간에 따라 필터링하는 메서드
    func filterChartRows(_ rows: [OldChartRow], startTime: Date, stopTime: Date) -> [OldChartRow] {
        let calendar = Calendar.current
        
        // 시작 시간에서 가장 가까운 3시간 간격을 계산
        let startHour = calendar.component(.hour, from: startTime)
        let nearestStartHour = (startHour / 3) * 3
        
        // 계산된 시작 시간으로 adjustedStartTime을 설정
        let adjustedStartTime = calendar.date(bySettingHour: nearestStartHour, minute: 0, second: 0, of: startTime) ?? startTime
        
        // adjustedStartTime과 stopTime 사이에 있는 차트 행들을 필터링
        let filtered = rows.filter { row in
            if let rowDate = DateFormatterManager.shared.dateFromString(row.time) {
                // 필터 조건: rowDate가 adjustedStartTime 이상이고 stopTime 이하인 경우
                return rowDate >= adjustedStartTime && rowDate <= stopTime
            }
            return false
        }
        
        // 필터링된 결과를 필터된차트 배열에 저장
        필터된차트 = filtered
        
        // 필터링된 행들을 반환
        return filtered
    }
}
