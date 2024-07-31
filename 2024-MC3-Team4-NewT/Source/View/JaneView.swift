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
//    @Query var chartRows: [ChartRow]
    var body: some View {
        let _: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH시"
            return formatter
        }()
        
        List {
//            ForEach(chartRows, id: \.day) { row in
//                HStack {
//                    Text("\(row.day), formatter:dateFormatter")
//                    HStack(alignment: .center, spacing: 8){
//                        Image(systemName: "location.north")
//                        Text("\(row.surfingValues.windSpeed)m/s")
//                    }
//                    HStack(alignment: .center, spacing: 8) {
//                        Image(systemName: "location.north.fill")
//                        VStack {
//                            Text("\(row.surfingValues.waveHeight)m")
//                            Text("\(row.surfingValues.wavePeriod)s")
//                        }
//                    }
//                    Text("\(row.surfingValues.waterTemperature)°C")
//                    HStack(alignment: .center, spacing: 8) {
//                        Text(row.surfingValues.weather)
//                        Text("\(row.surfingValues.airTemperature)")
//                    }
//                }
//            }
        }
    }
}

extension JaneView {
    func weatherIcon() {
        
    }
}

#Preview{
    JaneView()
}
