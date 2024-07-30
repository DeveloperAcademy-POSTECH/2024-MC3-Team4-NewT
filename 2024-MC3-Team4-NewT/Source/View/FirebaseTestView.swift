//
//  FirebaseTestView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/29/24.
//
import SwiftUI
import FirebaseFirestore

struct FirebaseTestView: View {
    @State private var items: [[String: Any]] = []

    var body: some View {
        NavigationView {
            VStack {
                List(items, id: \.self) { item in
                    VStack(alignment: .leading) {
                        if let airTemperature = item["temp"] as? Float {
                            Text("Air Temperature: \(airTemperature)")
                        }
                        if let wavePeriod = item["waves_period"] as? Float {
                            Text("Wave Period: \(wavePeriod)")
                        }
                    }
                }
            }
            .navigationTitle("Firebase 데이터")
            .onAppear {
                fetchItems()
            }
        }
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

            var fetchedItems: [[String: Any]] = []

            for document in documents {
                var data = document.data()

                // Double을 Float로 변환
                if let windSouth = data["wind_south"] as? Double {
                    data["wind_south"] = Float(windSouth)
                }
                if let temp = data["temp"] as? Double {
                    data["temp"] = Float(temp)
                }
                if let wavesHeight = data["waves_height"] as? Double {
                    data["waves_height"] = Float(wavesHeight)
                }
                if let wavesDirection = data["waves_direction"] as? Double {
                    data["waves_direction"] = Float(wavesDirection)
                }
                if let wavesPeriod = data["waves_period"] as? Double {
                    data["waves_period"] = Float(wavesPeriod)
                }
                if let windNorth = data["wind_north"] as? Double {
                    data["wind_north"] = Float(windNorth)
                }

                fetchedItems.append(data)
            }

            self.items = fetchedItems
        }
    }
}

#Preview {
    FirebaseTestView()
}
