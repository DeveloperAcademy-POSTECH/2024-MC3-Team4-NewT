import SwiftUI
import SwiftData


class RecordChartViewModel: ObservableObject {
    @Published var categories: Int = 0
    @Published var selectedDate = Date()
    @Published var startTime = Date()
    @Published var stopTime = Date()
    @Published var isEllipsisOnOff: Bool = false
    @Published var ismemo: Bool = false
    
//    let placeHolding1: String = "파도에 대한 간단한 메모를 남겨보세요."
//    let placeHolding2: String = "(최대 200자)"
//    let memoLimit: Int = 200
    
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
    
    
    func date(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateFormat = "MM월 dd일 (E)"
        return formatter.string(from: date)
    }
}
