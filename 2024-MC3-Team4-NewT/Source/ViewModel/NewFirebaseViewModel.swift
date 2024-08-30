//
//  NewFirebaseViewModel.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/28/24.
//
import SwiftData
import FirebaseFirestore
import Observation
import SwiftUI

class NewFirebaseViewModel: ObservableObject {
    @Published var SDDailySurfingValues: [DailySurfingValues] = []
    
    private let lastUpdateDateKey = "lastFirebaseUpdateDate" // UserDefaults 키
    
    func fetchFirebaseDailyChart(modelContext: ModelContext, collectionName: String) {
        
        do {
            // DailySurfingValues를 로컬 데이터베이스에서 가져옴
            let descriptor = FetchDescriptor<DailySurfingValues>(sortBy: [SortDescriptor(\.time)])
            self.SDDailySurfingValues = try modelContext.fetch(descriptor)
            print("로컬 데이터베이스에서 데이터를 성공적으로 불러왔습니다.")
            
        } catch {
            print("DailySurfingValues를 로컬에서 가져오는 동안 오류 발생: \(error)")
        }
        
        // SDDailySurfingValues가 비어 있을 때 무조건 Firebase에서 데이터를 가져오도록 설정
        if SDDailySurfingValues.isEmpty {
            print("로컬 데이터가 비어 있습니다. Firebase에서 데이터를 불러옵니다.")
            fetchFromFirebase(modelContext: modelContext, collectionName: collectionName)
        } else {
            // 마지막 업데이트 날짜 가져오기
            let lastUpdateDate = UserDefaults.standard.string(forKey: lastUpdateDateKey)
            
            // 현재 날짜 가져오기
            let currentDateString = DateFormatterManager.shared.compactDateFormatter.string(from: Date())
            
            // 날짜가 바뀌었는지 확인
            if lastUpdateDate == currentDateString {
                print("오늘 이미 데이터를 가져왔습니다. 마지막 업데이트 날짜: \(lastUpdateDate ?? "Unknown")")
                return
            }
            
            // Firebase에서 데이터를 가져오는 조건 만족 시 호출
            fetchFromFirebase(modelContext: modelContext, collectionName: collectionName)
        }
    }
    
    private func fetchFromFirebase(modelContext: ModelContext, collectionName: String) {
        // Firebase에서 데이터 가져오기
        let db = Firestore.firestore()
        db.collection(collectionName).getDocuments { snapshot, error in
            if let error = error {
                print("Firebase에서 문서를 가져오는 동안 오류 발생: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("Firebase에서 문서를 찾을 수 없습니다.")
                return
            }
            
            for document in documents {
                let data = document.data()
                
                if let timestampString = data["timestamp"] as? String,
                   let tempString = data["Temperature"] as? String,
                   let wavesHeightString = data["WaveHeight"] as? String,
                   let windSpeedEastWestString = data["WindSpeedEastWest"] as? String,
                   let windSpeedNorthSouthString = data["WindSpeedNorthSouth"] as? String,
                   let seaTempString = data["SeaTemperature"] as? String,
                   let weather = data["weather"] as? String,
                   let windDirectionString = data["WindDirection"] as? String {
                    
                    if let temp = Double(tempString),
                       let wavesHeight = Double(wavesHeightString),
                       let windSpeedEastWest = Double(windSpeedEastWestString),
                       let windSpeedNorthSouth = Double(windSpeedNorthSouthString),
                       let seaTemp = Double(seaTempString),
                       let windDirection = Double(windDirectionString) {
                        
                        let windSpeed = sqrt(pow(windSpeedEastWest, 2) + pow(windSpeedNorthSouth, 2))
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyyMMddHHmm"
                        
                        if let date = dateFormatter.date(from: timestampString) {
                            let formattedDate = DateFormatterManager.shared.detailedDateTimeFormatter.string(from: date)
                            
                            // 동일한 시간의 데이터가 이미 있는지 확인
                            if let existingIndex = self.SDDailySurfingValues.firstIndex(where: { $0.time == formattedDate }) {
                                // 기존 데이터를 업데이트
                                let existingValue = self.SDDailySurfingValues[existingIndex]
                                existingValue.waveHeight = Float(wavesHeight)
                                existingValue.windDirection = Float(windDirection)
                                existingValue.windSpeed = Float(windSpeed)
                                existingValue.weather = weather
                                existingValue.airTemperature = Float(temp)
                                existingValue.waterTemperature = Float(seaTemp)
                                existingValue.location = collectionName
                                
                                modelContext.insert(existingValue)
                                print("로컬 데이터 업데이트 완료")
                            } else {
                                // 새 데이터를 생성
                                let newSurfingValues = DailySurfingValues(
                                    time: formattedDate,
                                    waveDirection: Float.random(in: 180.0...240.0),
                                    waveHeight: Float(wavesHeight),
                                    wavePeriod: Float.random(in: 3.0...3.5),
                                    windDirection: Float(windDirection),
                                    windSpeed: Float(windSpeed),
                                    weather: weather,
                                    airTemperature: Float(temp),
                                    waterTemperature: Float(seaTemp),
                                    isHighTide: false,
                                    isLowTide: false,
                                    location: collectionName
                                )
                                modelContext.insert(newSurfingValues)
                                self.SDDailySurfingValues.append(newSurfingValues)
                                print("Firebase 데이터 삽입 완료")
                            }
                        }
                    }
                }
            }
            
            // 업데이트 날짜 기록
            let currentDateString = DateFormatterManager.shared.compactDateFormatter.string(from: Date())
            UserDefaults.standard.set(currentDateString, forKey: self.lastUpdateDateKey)
            print("Firebase 데이터를 성공적으로 업데이트하였습니다.")
        }
    }
}
