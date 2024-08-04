//
//  RecentChartsVIew.swift
//  2024-MC3-Team4-NewT
//
//  Created by 김이예은 on 7/31/24.
//

import SwiftUI

struct RecentChartsView3: View {
    private var dummyCharts: [ChartRowTmp]
    = [ChartRowTmp(day: Date(), surfingValues: SurfingValuesOne(waveDirection: 164.0, waveHeight: 0.16, wavePeriod: 4.75, windDirection: 234.36, windSpeed: 5.0, weather: "ra", airTemperature: 25.33, waterTemperature: 23.5), isHighTide: false, isLowTide: false),
       ChartRowTmp(day: Date(), surfingValues: SurfingValuesOne(waveDirection: 164.0, waveHeight: 0.16, wavePeriod: 4.75, windDirection: 234.36, windSpeed: 5.0, weather: "ra", airTemperature: 25.33, waterTemperature: 23.5), isHighTide: false, isLowTide: false),
       ChartRowTmp(day: Date(), surfingValues: SurfingValuesOne(waveDirection: 164.0, waveHeight: 0.16, wavePeriod: 4.75, windDirection: 234.36, windSpeed: 5.0, weather: "ra", airTemperature: 25.33, waterTemperature: 23.5), isHighTide: false, isLowTide: false)
    ]
    @State var sheetPop: Bool = false
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Text("자세한 정보")
                    .font(.title)
                    .padding()
                Spacer()
                Button{
                    sheetPop = false // 시트 닫기
                } label: {
                    Image("sheetXButton")
                }
            }
            .padding()
            Image("infoSheet")
        }
        .frame(maxHeight: UIScreen.main.bounds.height / 2) // 화면의 절반 높이
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

#Preview {
    RecentChartsView()
}
