import SwiftUI
import SwiftData


class RecordChartViewModel: ObservableObject {
    @Published var categoryIndex: Int = 0
    @Published var selectedDate = Date()
    @Published var startTime = Date()
    @Published var stopTime = Date()
    @Published var isEllipsisOnOff: [UUID: Bool] = [:]
    @Published var ismemo: Bool = false
    @Published var chartRowId: UUID = UUID()
    @Published var isPinButton: [UUID: Bool] = [:]
    @Published var isChartPinButton: [UUID: Bool] = [:]
    @Published var isMemoCheckingButton: [UUID: Bool] = [:]
    @Published var isPinCounter: Int = 0
    @Published var recordId = UUID()
    
    
    /// LotationView 변수
    @Published var selectedRegion: Region? = nil
    @Published var selectedItem: String = "포항 신항만해변"
    @Published var selectedItemBackgroundColor: Color = Color("backgroundSkyblue")
    @Published var selectedItemColor: Color = Color("surfBlue")
    @Published var isSelectButton: Bool = true
    @Published var showPin = false
    @Published var rowTime = ""
    @Published var pinRecord = Date()
    @Published var isRecord = false
    
    
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
            //            print("필터:\(test.time)")
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
    
    func evaluationText(for value: Int) -> String {
        switch value {
            case 1: return "별로예요"
            case 2: return "아쉬워요"
            case 3: return "보통이에요"
            case 4: return "만족해요"
            default: return "최고예요"
        }
    }
    
    func updateEllipsisState(for id: UUID) {
        for key in isEllipsisOnOff.keys {
            if key != id {
                isEllipsisOnOff[key] = false
                
            }
        }
        isEllipsisOnOff[id, default: false].toggle()
        
    }
    // UserDefaults에 row.time을 추가하는 함수
    func savePinTime(_ time: String,_ date: Date) {
        var pinTimes = UserDefaults.standard.stringArray(forKey: "pinTime") ?? []
        
        var pinRecord = UserDefaults.standard.stringArray(forKey: "pinRecord") ?? []
        var convertDate = DateFormatterManager.shared.convertDateToString(date: date)
        if !pinRecord.contains(convertDate) {
            pinRecord.append(convertDate)
            UserDefaults.standard.set(pinRecord, forKey: "pinRecord")
            print("들어갔음record:\(convertDate)")
            pinTimes.append(time)
            UserDefaults.standard.set(pinTimes, forKey: "pinTime")
            print("들어갔음time:\(time)")
        }
        
        
    }
    func confirm(_ time: String,_ date: Date){
        var pinTimes = UserDefaults.standard.stringArray(forKey: "pinTime") ?? []
        
        var pinRecord = UserDefaults.standard.stringArray(forKey: "pinRecord") ?? []
        var convertDate = DateFormatterManager.shared.convertDateToString(date: date)
        if pinRecord.contains(convertDate) {
            isRecord = true
        }
    }
    func deleteRecord(item: SurfingRecordOne,modelContext:ModelContext) {
        modelContext.delete(item) // Delete the SurfingRecordOne object from the context
        try? modelContext.save()  // Save the context to persist changes
    }
}
