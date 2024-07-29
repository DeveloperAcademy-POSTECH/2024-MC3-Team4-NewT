//
//  JaneVIew.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/21/24.
//

import SwiftUI
import SwiftData

struct JaneView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var chartRows: [ChartRow]
    
    let daysFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH시"
        formatter.locale = Locale(identifier: "ko_kr")
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일 EEEE"
        formatter.locale = Locale(identifier: "ko_kr")
        return formatter
    }()
    
    var body: some View {
        
        //MARK: MainChartView로 뺄 예정
        Section {
            Text("주간 차트").font(.title3)
            Text("\(dateFormatter.string(from: Date()))")
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()), // 시간
                    GridItem(.flexible()), // 바람
                    GridItem(.flexible()), // 파도
                    GridItem(.flexible()), // 수온
                    GridItem(.flexible())  // 날씨
                ], spacing: 10) {
                    Text("시간")
                    Text("바람")
                    Text("파도")
                    Text("수온")
                    Text("날씨")
                    
                    //한 줄씩 불러오기 위해 함수로 뺌
                }
                .padding()
            }.onAppear{
//                addDummyData()
    
            }
        }
        
        
    }
}


extension JaneView {
    func weatherIcon() {
        
    }
    
    func addDummyData() {
        let context = modelContext //modelContext 가져옴
        for chartRow in dummyChartRows {
//            context.insert(chartRow) // 데이터베이스에 ChartRow 객체 추가
        }
        try? context.save()
    }
    
//    func ChartRowList() {
//        var chartRows: [ChartRow] = dummyChartRows
//        ForEach(chartRows) { row in
//            Text("\(daysFormatter.string(from: row.day))").textScale(.secondary)
//            HStack(alignment: .center, spacing: 8) {
//                Image(systemName: "location.north")
//                Text("\(row.surfingValues.windSpeed, specifier: "%.1f")m/s").textScale(.secondary)
//            }
//            HStack(alignment: .center, spacing: 8) {
//                Image(systemName: "location.north.fill")
//                VStack {
//                    Text("\(row.surfingValues.waveHeight, specifier: "%.1f")m").textScale(.secondary)
//                    Text("\(row.surfingValues.wavePeriod, specifier: "%.1f")s").textScale(.secondary)
//                }
//            }
//            Text("\(row.surfingValues.waterTemperature, specifier: "%.0f")°C").textScale(.secondary)
//            HStack(alignment: .center, spacing: 8) {
//                Text(row.surfingValues.weather).textScale(.secondary)
//                Text("\(row.surfingValues.airTemperature, specifier: "%.0f")°C").textScale(.secondary)
//            }
//        }
//    }
    
}
