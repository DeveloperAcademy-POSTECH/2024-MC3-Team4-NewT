//
//  FirebaseObservable.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/1/24.
//
import SwiftData
import FirebaseFirestore
import Observation
import SwiftUI

@Observable
class OldFirebaseObservable {
    // ChartRow 타입의 데이터를 저장하는 배열
    var items: [OldChartRow] = []
    var container = try? ModelContainer(for:
                                            OldDailyWeatherOld.self,
                                        OldSurfingValues.self,
                                        OldChartRow.self,
                                        OldDailyWeather.self,
                                        OldSurfingRecordOne.self,
                                        OldStatistics.self
    )
    // Firebase에서 데이터를 가져와서 주어진 ChartRow 배열을 업데이트하는 함수
    func fetchFirebase(modelContext: ModelContext, collectionName: String, chartRow: [OldChartRow]) {
        // Firestore DB 접근위한 인스턴스 생성
        let db = Firestore.firestore()
        for item in chartRow{
            if let aa = item.surfingRecordStartTime{
                print("\(aa):통과")
            }
            else{
                
                modelContext.delete(item)
            }
        }
        
        // Firebase에서 지정한 컬렉션(collectionName)의 모든 문서를 가져옴
        db.collection(collectionName).getDocuments { snapshot, error in
            if let error = error {
                // 에러 발생시 종료
                print("Error getting documents: \(error.localizedDescription)")
                return
            }
            
            // 데이터가 비어 있는 경우 처리
            guard let documents = snapshot?.documents else {
                print("No documents found") // 데이터가 없음을 출력
                return
            }
            
            // 가져온 문서들에 대해 반복 처리
            for document in documents {
                let data = document.data() // 문서의 데이터를 딕셔너리 형태로 가져옴
                
                // 필요한 데이터가 있는지 확인하고, 있다면 변환
                if let windSouth = data["wind_south"] as? Double,
                   let timestamp = data["timestamp"] as? Timestamp,
                   let temp = data["temp"] as? Double,
                   let wavesHeight = data["waves_height"] as? Double,
                   let wavesDirection = data["waves_direction"] as? Double,
                   let wavesPeriod = data["waves_period"] as? Double,
                   let windNorth = data["wind_north"] as? Double {
                    
                    // SurfingValues2 객체를 동일한 컨텍스트에서 생성하여 데이터 저장
                    let surfingValues = OldSurfingValues(
                        waveDirection: Float(wavesDirection),
                        waveHeight: Float(wavesHeight),
                        wavePeriod: Float(wavesPeriod),
                        windDirection: Float(windNorth),
                        windSpeed: Float(windSouth),
                        weather: "sunny", // 날씨 정보는 "sunny"로 고정
                        airTemperature: Float(temp)*0.1,
                        waterTemperature: Float(temp)*0.1
                    )
                    modelContext.insert(surfingValues)
                    
                    // 타임스탬프(timestamp)를 yyyy-MM-dd HH:mm:ss로 변환(싱글톤 패턴 사용)
                    let formattedDate = DateFormatterManager.shared.longDateFormatter.string(from: timestamp.dateValue())
                    
                    // 테스트용 로그 찍기
                    //                    print("파이어베이스 time:\(formattedDate)")
                    
                    // 새 ChartRow 객체를 동일한 컨텍스트에서 생성
                    let newItem = OldChartRow(
                        time: formattedDate,
                        surfingValues: surfingValues,
                        isHighTide: false,
                        isLowTide: false
                    )
                    //                    if chartCollection[index].time
                    modelContext.insert(newItem)
                    
                    
                }
            }
            
        }
    }
    
    // 날짜별로 그룹화하여 [(String, [ChartRow])] 형태의 배열로 반환하는 함수
    func groupedByDate(chartRow: [OldChartRow]) -> [(key: String, value: [OldChartRow])] {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        // 날짜별로 그룹화
        let grouped = Dictionary(grouping: chartRow) { item -> String in
            return String(item.time.prefix(10)) // 날짜 부분만 추출하여 그룹화
        }
        
        // 키를 정렬하여 배열로 반환
        return grouped.sorted { $0.key < $1.key }
    }
}
