//
//  JaneVIew.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/21/24.
//

import SwiftUI
import SwiftData

struct JaneView: View {
//    @StateObject private var viewModel = ChartRowViewModel()
    @Environment(\.modelContext) private var modelContext
    @Query var chartRows: [ChartRow]
    var body: some View {

        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH시"
            formatter.locale = Locale(identifier: "ko_kr")
            return formatter
        }()
        List {
            ForEach(chartRows) { row in
                HStack {
                    Text("\(dateFormatter.string(from: row.day))")
                    HStack(alignment: .center, spacing: 8){
                        Image(systemName: "location.north")
                        Text("\(row.surfingValues.windSpeed, specifier: "%.1f")m/s")
                    }
                    HStack(alignment: .center, spacing: 8) {
                        Image(systemName: "location.north.fill")
                        VStack {
                            Text("\(row.surfingValues.waveHeight, specifier: "%.1f")m")
                            Text("\(row.surfingValues.wavePeriod, specifier: "%.1f")s")
                        }
                    }
                    Text("\(row.surfingValues.waterTemperature, specifier: "%.0f")°C")
                    HStack(alignment: .center, spacing: 8) {
                        Text(row.surfingValues.weather)
                        Text("\(row.surfingValues.airTemperature, specifier: "%.0f")°C")
                    }
                }
            }
        }.onAppear{
            addDummyData()
        }
    }

}


extension JaneView {
    func weatherIcon() {
        
    }
    
    func addDummyData() {
        let context = modelContext // 현재의 modelContext를 가져옵니다.
        for chartRow in dummyChartRows {
            context.insert(chartRow) // 데이터베이스에 ChartRow 객체를 추가합니다.
        }
        try? context.save() // 변경 사항을 저장합니다.
    }

    
}
