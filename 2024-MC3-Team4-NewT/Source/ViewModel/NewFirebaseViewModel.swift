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
    @Published var 기존모델값들: [DailySurfingValues] = []

    func fetchFirebase(modelContext: ModelContext, collectionName: String) {
        // Fetch existing data from SwiftData
        do {
            let descriptor = FetchDescriptor<DailySurfingValues>(sortBy: [SortDescriptor(\.time, order: .reverse)])
            self.기존모델값들 = try modelContext.fetch(descriptor)
        } catch {
            print("Error fetching DailySurfingValues: \(error)")
        }

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
                            let formattedDate = DateFormatterManager.shared.longDateFormatter2.string(from: date)
                            
                            // Check if an instance with the same time already exists
                            if let existingIndex = self.기존모델값들.firstIndex(where: { $0.time == formattedDate }) {
                                // Update existing instance
                                let existingValue = self.기존모델값들[existingIndex]
                                existingValue.waveHeight = Float(wavesHeight)
                                existingValue.windDirection = Float(windDirection)
                                existingValue.windSpeed = Float(windSpeed)
                                existingValue.weather = weather
                                existingValue.airTemperature = Float(temp)
                                existingValue.waterTemperature = Float(seaTemp)
                                existingValue.location = collectionName
                                
                                modelContext.insert(existingValue)
                                print("update")
                            } else {
                                // Create new instance
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
                                self.기존모델값들.append(newSurfingValues)
                                print("insert")
                            }
                        }
                    }
                }
            }
            
            // Sort the updated array
            self.기존모델값들.sort { $0.time > $1.time }
        }
    }
}
