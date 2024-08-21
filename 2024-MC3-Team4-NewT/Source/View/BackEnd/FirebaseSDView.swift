//
//  FireSDView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/2/24.
//
import SwiftUI
import SwiftData

struct FirebaseSDView: View {
    @Environment(\.modelContext) var modelContext
    var fbo = FirebaseObservable()
    @Query(sort: \OldChartRow.time) var chartRow: [OldChartRow]
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    // 날짜별로 그룹화된 데이터를 섹션으로 표시
                    ForEach(fbo.groupedByDate(chartRow: chartRow), id: \.key) { date, items in
                        Section(header: Text("날짜: \(date)")) {
                            ForEach(items, id: \.self) { item in
                                VStack(alignment: .leading) {
                                    Text("시간: \(item.time)")
                                    Text("온도: \(item.surfingValues.airTemperature)")
                                    Text("파주기: \(item.surfingValues.wavePeriod)")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("FirebaseSDView")
            .onAppear {
                fbo.fetchFirebase(modelContext: modelContext, collectionName: "wolpo", chartRow: chartRow)
                
            }
        }
    }
}
