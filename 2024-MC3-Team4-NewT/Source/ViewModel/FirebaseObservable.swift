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
class FirebaseObservable {
    var items: [ChartRow] = []
    
    func fetchFirebase(modelContext: ModelContext, collectionName: String, chartRow: [ChartRow]) -> [ChartRow] {
        
        let db = Firestore.firestore()
        var updatedChartRows = chartRow // 입력으로 받은 chartRow를 복사하여 작업
        
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
                if let windSouth = data["wind_south"] as? Double,
                   let timestamp = data["timestamp"] as? Timestamp,
                   let temp = data["temp"] as? Double,
                   let wavesHeight = data["waves_height"] as? Double,
                   let wavesDirection = data["waves_direction"] as? Double,
                   let wavesPeriod = data["waves_period"] as? Double,
                   let windNorth = data["wind_north"] as? Double {
                    
                    let surfingValues = SurfingValues2(
                        waveDirection: Float(wavesDirection),
                        waveHeight: Float(wavesHeight),
                        wavePeriod: Float(wavesPeriod),
                        windDirection: Float(windNorth),
                        windSpeed: Float(windSouth),
                        weather: "sunny",
                        airTemperature: Float(temp),
                        waterTemperature: Float(temp)
                    )
                    
                    // 타임스탬프를 한국 시간대에 맞는 문자열로 변환
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
                    let formattedDate = dateFormatter.string(from: timestamp.dateValue())
                    print("파이어베이스 time:\(formattedDate)")
                    
                    // 'time'을 String으로 저장
                    let newItem = ChartRow(
                        time: formattedDate,
                        surfingValues: surfingValues,
                        isHighTide: false,
                        isLowTide: false
                    )
                    
                    // 기존 chartRow 배열에서 동일한 'time' 값을 가진 데이터를 확인
                    if let existingIndex = updatedChartRows.firstIndex(where: { $0.time == formattedDate }) {
                        // 기존 데이터가 있으면 업데이트
                        updatedChartRows[existingIndex].surfingValues = surfingValues
                        updatedChartRows[existingIndex].isHighTide = newItem.isHighTide
                        updatedChartRows[existingIndex].isLowTide = newItem.isLowTide
                    } else {
                        // 기존 데이터가 없으면 새로 추가
                        modelContext.insert(newItem)
                        updatedChartRows.append(newItem)
                    }
                    
                }
            }
            
            // 업데이트된 items 리스트를 저장
            self.items = updatedChartRows
        }
        
        return updatedChartRows // 최종 업데이트된 chartRow 리스트 반환
    }
}
