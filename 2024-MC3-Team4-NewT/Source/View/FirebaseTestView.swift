//
//  FirebaseTestView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/29/24.
//
import SwiftUI
import SwiftData

struct FirebaseTestView: View {
    @Environment(\.modelContext) var modelContext
    var fbo = FirebaseObservable()
    var sdo = SwiftDataObservable()
    @Query var chartRow:[ChartRow]
    var body: some View {
        NavigationView {
            VStack {
                List(fbo.items, id: \.self) { item in
                    VStack(alignment: .leading) {
                        Text("온도: \(item.surfingValues.airTemperature)")
                        Text("파주기: \(item.surfingValues.wavePeriod)")
                    }
                }
            }
            .onAppear {
                fbo.fetchFirebase(modelContext: modelContext, collectionName: "pohang", chartRow: chartRow) //fbo.items에 결과값 생성됨
                

                
            }
        }
    }
}
