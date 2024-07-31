//
//  WaveObservable.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/30/24.
//

//import SwiftUI
//import FirebaseFirestore
//
//class WaveObservable{
//    var item:ChartRowTmp
//    init(item: ChartRowTmp) {
//        self.item = item
//    }
//    func fetchItems() {
//        let db = Firestore.firestore()
//        db.collection("pohang").getDocuments { snapshot, error in
//            if let error = error {
//                print("Error getting documents: \(error.localizedDescription)")
//                return
//            }
//
//            guard let documents = snapshot?.documents else {
//                print("No documents found")
//                return
//            }
//
//            var fetchedItems: [ChartRowTmp] = []
//
//            for document in documents {
//                let data = document.data()
//                if let windSouth = data["wind_south"] as? Double,
//                   let timestamp = data["timestamp"] as? Timestamp,
//                   let temp = data["temp"] as? Double,
//                   let wavesHeight = data["waves_height"] as? Double,
//                   let wavesDirection = data["waves_direction"] as? Double,
//                   let wavesPeriod = data["waves_period"] as? Double,
//                   let windNorth = data["wind_north"] as? Double {
//
//                    let surfingValues = SurfingValues(
//                        waveDirection: Float(wavesDirection),
//                        waveHeight: Float(wavesHeight),
//                        wavePeriod: Float(wavesPeriod),
//                        windDirection: Float(windNorth),
//                        windSpeed: Float(windSouth),
//                        weather: "sunny",
//                        airTemperature: Float(temp),
//                        waterTemperature: Float(temp)
//                    )
//
//                    let item = ChartRowTmp(
//                        day: timestamp.dateValue(),
//                        surfingValues: surfingValues,
//                        isHighTide: false,
//                        isLowTide: false
//                    )
//
//                    fetchedItems.append(item)
//                }
//            }
//        }
//    }
//}
//
