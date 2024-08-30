import SwiftData
import FirebaseFirestore
import Observation
import SwiftUI

@Observable
class FirebaseObservable {
    var items: [OldChartRow] = []
    var container = try? ModelContainer(for:
                                            OldDailyWeatherOld.self,
                                        OldSurfingValues.self,
                                        OldChartRow.self,
                                        OldDailyWeather.self,
                                        OldSurfingRecordOne.self,
                                        OldStatistics.self
    )
    
    func fetchFirebase(modelContext: ModelContext, collectionName: String, chartRow: [OldChartRow]) {
        let db = Firestore.firestore()

        
        db.collection(collectionName).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            for document in documents {
                let data = document.data()
                
                // 모든 데이터가 String으로 제공되므로 적절한 형식으로 변환
                if let timestampString = data["timestamp"] as? String,
                   let tempString = data["Temperature"] as? String,
                   let wavesHeightString = data["WaveHeight"] as? String,
                   let windSpeedEastWestString = data["WindSpeedEastWest"] as? String,
                   let windSpeedNorthSouthString = data["WindSpeedNorthSouth"] as? String,
                   let seaTempString = data["SeaTemperature"] as? String,
                   let weather = data["weather"] as? String,
                   let windDirectionString = data["WindDirection"] as? String {
                    
                    // String을 적절한 타입으로 변환
                    if let temp = Double(tempString),
                       let wavesHeight = Double(wavesHeightString),
                       let windSpeedEastWest = Double(windSpeedEastWestString),
                       let windSpeedNorthSouth = Double(windSpeedNorthSouthString),
                       let seaTemp = Double(seaTempString),
                       let windDirection = Double(windDirectionString) {
                        
                        // 동서 및 남북 바람 속도를 이용하여 전체 바람 속도 계산
                        let windSpeed = sqrt(pow(windSpeedEastWest, 2) + pow(windSpeedNorthSouth, 2))
                        
                        // SurfingValues 인스턴스 생성
                        let surfingValues = OldSurfingValues(
                            waveDirection: Float.random(in: 180.0...240.0),
                            waveHeight: Float(wavesHeight),
                            
                            wavePeriod: Float.random(in: 3.0...3.5), // waves_period 데이터가 없으므로 기본값 사용
                            windDirection: Float(windDirection),
                            windSpeed: Float(windSpeed),
                            weather: weather,
                            airTemperature: Float(temp),
                            waterTemperature: Float(seaTemp)
                        )
                        print("파고:\(wavesHeight)")
                        modelContext.insert(surfingValues)
                        
                        // 타임스탬프를 yyyyMMddHHmm 형식에서 Date로 변환
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyyMMddHHmm"
                        if let date = dateFormatter.date(from: timestampString) {
                            let formattedDate = DateFormatterManager.shared.detailedDateTimeFormatter.string(from: date)
                            
                            // ChartRow 인스턴스 생성
                            let newItem = OldChartRow(
                                time: formattedDate,
                                surfingValues: surfingValues,
                                isHighTide: false,
                                isLowTide: false
                            )
                            modelContext.insert(newItem)
                        } else {
                            print("Invalid timestamp format: \(timestampString)")
                        }
                    }
                }
            }
        }
    }
    
    func groupedByDate(chartRow: [OldChartRow]) -> [(key: String, value: [OldChartRow])] {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let grouped = Dictionary(grouping: chartRow) { item -> String in
            return String(item.time.prefix(10))
        }
        
        return grouped.sorted { $0.key < $1.key }
    }
}
