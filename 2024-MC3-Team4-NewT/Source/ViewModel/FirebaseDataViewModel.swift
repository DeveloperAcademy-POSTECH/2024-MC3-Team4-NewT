//
//  FirebaseDataViewModel.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/31/24.
//
import SwiftUI
import FirebaseFirestore
import SwiftData

class FirebaseDataViewModel: ObservableObject {
    @Published var items: [ChartRow] = []
    @Published var dateRange: String = ""
    
    init() {
        fetchItems()
    }

    func fetchItems() {
        let db = Firestore.firestore()
        db.collection("pohang").getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }

            var fetchedItems: [ChartRow] = []

            for document in documents {
                let data = document.data()
                if let windSouth = data["wind_south"] as? Double,
                   let timestamp = data["timestamp"] as? Timestamp,
                   let temp = data["temp"] as? Double,
                   let wavesHeight = data["waves_height"] as? Double,
                   let wavesDirection = data["waves_direction"] as? Double,
                   let wavesPeriod = data["waves_period"] as? Double,
                   let windNorth = data["wind_north"] as? Double {

                    let surfingValues = SurfingValues(
                        waveDirection: Float(wavesDirection),
                        waveHeight: Float(wavesHeight),
                        wavePeriod: Float(wavesPeriod),
                        windDirection: Float(windNorth),
                        windSpeed: Float(windSouth),
                        weather: "sunny",
                        airTemperature: Float(temp),
                        waterTemperature: Float(temp)
                    )
//
//                    let item = ChartRow(
//                        day: timestamp.dateValue(),
//                        surfingValues: surfingValues,
//                        isHighTide: false,
//                        isLowTide: false
//                    )
//
//                    fetchedItems.append(item)
                }
            }
//
//            DispatchQueue.main.async {
//                self.items = fetchedItems
//
//                // 날짜 범위 계산
//                if let firstDate = fetchedItems.map({ $0.day }).min(),
//                   let lastDate = fetchedItems.map({ $0.day }).max() {
//                    let dateRangeText = "\(dateFormatterShort.string(from: firstDate)) ~ \(dateFormatterShort.string(from: lastDate))"
//                    self.dateRange = "데이터 범위: \(dateRangeText)"
//                } else {
//                    self.dateRange = "데이터 범위: 없음"
//                }
//            }
        }
    }
}

private let dateFormatterShort: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = "yyyy년 MM월 dd일"
    return formatter
}()
