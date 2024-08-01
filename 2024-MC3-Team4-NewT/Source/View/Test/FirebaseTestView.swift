//
//  FirebaseTestView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/29/24.
//
//
//  FirebaseTestView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/29/24.
//
//
//  FirebaseTestView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/29/24.
//
import SwiftUI
import FirebaseFirestore

struct FirebaseTestView: View {
    @State private var items: [ChartRowTmp] = []

    var body: some View {
        NavigationView {
            VStack {
                List(items, id: \.self) { item in
                    VStack(alignment: .leading) {
                        // day를 원하는 형식으로 변환하여 출력
                        Text("time: \(formattedDate(item.day))")
                        Text("온도: \(item.surfingValues.airTemperature)")
                        Text("파주기: \(item.surfingValues.wavePeriod)")
                    }
                }
            }
            .navigationTitle("Firebase 데이터")
            .onAppear {
                fetchItems()
            }
        }
    }

    // Date를 "yyyy-MM-dd HH:mm:ss" 형식의 String으로 변환하는 함수
    func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"  // 원하는 형식으로 설정
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul") // 한국 시간대 설정
        return dateFormatter.string(from: date)
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

            var fetchedItems: [ChartRowTmp] = []

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

                    let item = ChartRowTmp(
                        day: timestamp.dateValue(),
                        surfingValues: surfingValues,
                        isHighTide: false,
                        isLowTide: false
                    )

                    fetchedItems.append(item)
                }
            }

            self.items = fetchedItems
        }
    }
}

#Preview {
    FirebaseTestView()
}
