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
            ScrollView {
                VStack {
                    Text("데이터 개수: \(items.count)개")
                        .font(.title)
                        .padding()
                    
                    ForEach(items, id: \.self) { item in
                        CardView(item: item)
                            .padding(.horizontal)
                            .padding(.bottom, 10) // 카드 사이의 간격을 추가
                    }
                }
                .padding(.horizontal)
            }
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

struct CardView: View {
    let item: ChartRowTmp
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("날짜: \(item.day, formatter: dateFormatter)")
                .font(.headline)
            Text("기온: \(item.surfingValues.airTemperature)°C")
            Text("파고: \(item.surfingValues.waveHeight)m")
            Text("파주기: \(item.surfingValues.wavePeriod)초")
            Text("파향: \(item.surfingValues.waveDirection)°")
            Text("풍향: \(item.surfingValues.windDirection)°")
            Text("풍속: \(item.surfingValues.windSpeed)m/s")
            Text("날씨: \(item.surfingValues.weather)")
            Text("수온: \(item.surfingValues.waterTemperature)°C")
            Text("만조: \(item.isHighTide ? "예" : "아니오")")
            Text("간조: \(item.isLowTide ? "예" : "아니오")")
        }
        .padding()
        .frame(maxWidth: .infinity) // 카드가 가로로 확장되도록 설정
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = "yyyy년 MM월 dd일 HH시"
    return formatter
}()

#Preview {
    FirebaseTestView()
}
