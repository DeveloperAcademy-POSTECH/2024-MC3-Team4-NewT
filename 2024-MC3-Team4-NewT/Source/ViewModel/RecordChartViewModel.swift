import SwiftUI
import SwiftData


class RecordChartViewModel: ObservableObject {
    @Published var categories: Int = 0
    @Published var selectedDate = Date()
    @Published var startTime = Date()
    @Published var stopTime = Date()
    @Published var isEllipsisOnOff: Bool = false
    @Published var ismemo: Bool = false
    @Published var isID: UUID = UUID()
    
    /// LotationView 변수
    @Published var selectedRegion: Region? = nil
    @Published var selectedItem: String = "포항 신항만해변"
    @Published var selectedItemBackgroundColor: Color = Color("backgroundSkyblue")
    @Published var selectedItemColor: Color = Color("surfBlue")
    @Published var isSelectButton: Bool = true
    
    func filteredRecordChart(charts: [ChartRow], recordOne: SurfingRecordOne) -> [ChartRow] {
        var 필터된데이터: [ChartRow] = []
        
        for chartRow in charts {
            if let associatedRecord = chartRow.surfingRecordStartTime {
                if associatedRecord == recordOne.surfingStartTime {
                    필터된데이터.append(chartRow)
                }
            }
        }
        for test in 필터된데이터{
            print("필터:\(test.time)")
        }
//        print("필터된 데이터:\(필터된데이터.first?.time)")
        return 필터된데이터
    }

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
