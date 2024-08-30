//
//  RecordCreateViewModel.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/5/24.
//

import SwiftUI
import SwiftData

// ViewModel 클래스: RecordCreateView에서 사용할 데이터와 로직을 관리
class RecordCreateViewModel: ObservableObject {
    // 사용자에게 선택된 날짜
    @Published var selectedDate = Date()
    
    // 사용자가 선택한 시작 시간
    @Published var startTime = Date()
    
    // 사용자가 선택한 종료 시간
    @Published var stopTime = Date()
    
    // 사용자가 선택한 점수
    @Published var selectedScore: Int = 0
    
    // 차트 스크롤 여부를 결정 (스크롤 가능 여부)
    @Published var isChartScroll: Bool = true
    
    // 사용자가 설정한 점수 (Double 형식)
    @Published var isScore = 0.0
    
    // 메모가 입력되었는지 여부
    @Published var isMemo: Bool = true
    
    // 점수에 대한 텍스트
    @Published var isScoreText = ""
    
    // 메모 내용
    @Published var memo: String = ""
    
    // View의 높이 설정
    @Published var heightSize: CGFloat = 245.0
    
    // 메모 입력란의 플레이스홀더 텍스트 1
    var placeHolding1: String = "파도에 대한 간단한 메모를 남겨보세요."
    
    // 메모 입력란의 플레이스홀더 텍스트 2
    var placeHolding2: String = "(최대 200자)"
    
    // 메모의 최대 글자 수 제한
    let memoLimit: Int = 200
    
    // 차트 행 수를 계산하는 프로퍼티
    var chartCounter: Int {
        var counter: Int = 1
        if stopHour > startHour {
            // 시작 시간과 종료 시간 사이의 시간 차이를 계산하여 행 수를 설정
            counter = (stopHour - startHour) + 1
        }
        return counter
    }
    
    // 시작 시간의 시간(Hour) 부분을 반환하는 계산 프로퍼티
    var startHour: Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: startTime)
    }
    
    // 종료 시간의 시간(Hour) 부분을 반환하는 계산 프로퍼티
    var stopHour: Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: stopTime)
    }
    
    // 차트의 스크롤 가능 여부를 업데이트하는 메서드
    func updateChartScroll() {
        let counter = chartCounter
        if counter > 3 {
            // 차트 행 수가 3개를 초과하면 스크롤을 비활성화
            isChartScroll = false
        } else {
            // 차트 행 수가 3개 이하이면 스크롤을 활성화
            isChartScroll = true
        }
    }
    
    // ViewModel의 데이터를 초기 상태로 리셋하는 메서드
    func resetData() {
        // 모든 속성을 초기 값으로 재설정
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
