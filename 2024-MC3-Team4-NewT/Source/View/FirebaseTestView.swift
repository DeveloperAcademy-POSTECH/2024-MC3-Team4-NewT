//
//  FirebaseTestView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/29/24.
//
import SwiftUI
import FirebaseFirestore
import SwiftData

struct FirebaseTestView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = FirebaseDataViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("데이터 개수: \(viewModel.items.count)개")
                        .font(.title)
                        .padding()
                    
                    Text(viewModel.dateRange)
                        .font(.subheadline)
                        .padding()
                    
                    ForEach(viewModel.items, id: \.self) { item in
                        CardView(item: item)
                            .padding(.horizontal)
                            .padding(.bottom, 10) // 카드 사이의 간격을 추가
                            .onAppear {
                                insertItem(item)
                            }
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            // 초기 데이터 삽입
            for item in viewModel.items {
                insertItem(item)
            }
        }
    }
    
    private func insertItem(_ item: ChartRow) {
        DispatchQueue.main.async {
//            modelContext.insert(DailyWeather(day: "one", chartCollection: []))
        }
    }
}

struct CardView: View {
    let item: ChartRow
    
    var body: some View {
        VStack(alignment: .leading) {
//            Text("날짜: \(dateFormatter.string(from: item.day))")
//                .font(.headline)
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


#Preview {
    FirebaseTestView()
}
