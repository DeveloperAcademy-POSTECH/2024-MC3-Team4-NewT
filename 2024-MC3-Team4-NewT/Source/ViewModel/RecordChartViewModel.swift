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
    
    // LocationView 관련 변수
    @Published var selectedRegion: Region? = nil
    @Published var selectedItem: String = "포항 신항만해변"
    @Published var selectedItemBackgroundColor: Color = Color("backgroundSkyblue")
    @Published var selectedItemColor = Color("surfBlue")
    @Published var isSelectButton: Bool = true
    @Published var showPin = false
    @Published var rowTime = ""
    @Published var pinRecord = Date()
    @Published var isRecord = false
    
    // RecordChart에서 필터링된 데이터를 반환하는 함수
    func filteredRecordChart(charts: [ChartRow], recordOne: SurfingRecordOne) -> [ChartRow] {
        return charts.filter { $0.surfingRecordStartTime == recordOne.surfingStartTime }
    }

    // 평가 텍스트를 반환하는 함수
    func evaluationText(for value: Int) -> String {
        switch value {
            case 1: return "별로예요"
            case 2: return "아쉬워요"
            case 3: return "보통이에요"
            case 4: return "만족해요"
            default: return "최고예요"
        }
    }

    // Ellipsis 상태 업데이트 함수
    func updateEllipsisState(for id: UUID) {
        for key in isEllipsisOnOff.keys {
            if key != id {
                isEllipsisOnOff[key] = false
            }
        }
        isEllipsisOnOff[id, default: false].toggle()
    }

    // Pin Time 저장 함수
    func savePinTime(_ time: String, _ date: Date) {
        var pinTimes = UserDefaults.standard.stringArray(forKey: "pinTime") ?? []
        var pinRecords = UserDefaults.standard.stringArray(forKey: "pinRecord") ?? []

        let convertDate = DateFormatterManager.shared.convertDateToString(date: date)
        if !pinRecords.contains(convertDate) {
            pinRecords.append(convertDate)
            pinTimes.append(time)
            UserDefaults.standard.set(pinRecords, forKey: "pinRecord")
            UserDefaults.standard.set(pinTimes, forKey: "pinTime")
            print("Pin saved - Date: \(convertDate), Time: \(time)")
        }
    }

    // 기록이 이미 존재하는지 확인하는 함수
    @MainActor
    func confirmPin(_ time: String, _ date: Date) {
        let pinRecords = UserDefaults.standard.stringArray(forKey: "pinRecord") ?? []
        let convertDate = DateFormatterManager.shared.convertDateToString(date: date)
        
        if pinRecords.contains(convertDate) {
            self.isRecord = true
            print("변경isRecord")
        } else {
            
            self.showPin = true
            print("변경showPin")
            
        }
    }

    
}


