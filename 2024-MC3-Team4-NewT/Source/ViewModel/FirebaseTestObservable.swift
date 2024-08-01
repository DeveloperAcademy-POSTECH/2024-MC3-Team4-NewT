//
//  FirebaseTestObservable.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/2/24.
//

import SwiftData
import FirebaseFirestore
import Observation
import SwiftUI

@Observable
class FirebaseTestObservable {
    // ChartRow 타입의 데이터를 저장하는 배열
    var items: [ChartRow] = []
    
    // Firebase에서 데이터를 가져와서 주어진 ChartRow 배열을 업데이트하는 함수
    func fetchFirebase(modelContext: ModelContext, collectionName: String, chartRow: [ChartRow]) -> [ChartRow] {
        
        let db = Firestore.firestore() // Firebase Firestore 데이터베이스에 접근하기 위한 인스턴스 생성
        var updatedChartRows = chartRow // 매개변수로 받은 chartRow 배열을 복사하여 작업에 사용할 배열로 선언
        
        // Firebase에서 지정한 컬렉션(collectionName)의 모든 문서를 가져옴
        db.collection(collectionName).getDocuments { snapshot, error in
            if let error = error {
                // 데이터를 가져오는 도중에 에러가 발생한 경우, 에러 메시지를 출력하고 함수를 종료
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
                    
                    // SurfingValues2 객체를 생성하여 데이터 저장
                    let surfingValues = SurfingValues2(
                        waveDirection: Float(wavesDirection),
                        waveHeight: Float(wavesHeight),
                        wavePeriod: Float(wavesPeriod),
                        windDirection: Float(windNorth),
                        windSpeed: Float(windSouth),
                        weather: "sunny", // 날씨 정보는 "sunny"로 고정
                        airTemperature: Float(temp),
                        waterTemperature: Float(temp)
                    )
                    
                    // 타임스탬프(timestamp)를 한국 시간대에 맞춘 문자열로 변환
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // 날짜와 시간 형식 설정
                    dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul") // 한국 시간대 설정
                    let formattedDate = dateFormatter.string(from: timestamp.dateValue()) // Date를 문자열로 변환
                    print("파이어베이스 time:\(formattedDate)") // 변환된 시간 출력
                    
                    // 새 ChartRow 객체 생성
                    let newItem = ChartRow(
                        time: formattedDate, // 변환된 시간 문자열을 time에 저장
                        surfingValues: surfingValues,
                        isHighTide: false, // 만조 여부는 false로 설정
                        isLowTide: false // 간조 여부는 false로 설정
                    )
                    
                    // 이미 업데이트된 ChartRow 배열에서 동일한 'time' 값을 가진 데이터를 찾음
                    if let existingIndex = updatedChartRows.firstIndex(where: { $0.time == formattedDate }) {
                        // 동일한 time 값을 가진 데이터가 이미 있으면 업데이트
                        updatedChartRows[existingIndex].surfingValues = surfingValues
                        updatedChartRows[existingIndex].isHighTide = newItem.isHighTide
                        updatedChartRows[existingIndex].isLowTide = newItem.isLowTide
                    } else {
                        // 동일한 time 값을 가진 데이터가 없으면 새로 추가
                        modelContext.insert(newItem) // 새로 생성된 데이터를 모델 컨텍스트에 삽입
                        updatedChartRows.append(newItem) // 업데이트된 배열에 추가
                    }
                }
            }
            self.items = updatedChartRows
        }
        
        // 최종적으로 업데이트된 chartRow 리스트를 반환
        return updatedChartRows
    }
}
