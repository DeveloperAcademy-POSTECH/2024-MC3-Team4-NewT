//
//  TestView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/21/24.
//

import SwiftUI

struct TestView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 20.0){
                NavigationLink(destination: PiriView()){
                    Text("파이리")
                }
                NavigationLink(destination: JaneView()){
                    Text("제인")
                }
                NavigationLink(destination: SisiView()){
                    Text("씨씨")
                }
//                NavigationLink(destination: NadaView()){
//                    Text("나다")
//                }
                NavigationLink(destination: FitChartView()){
                    Text("FitChartView")
                }
                NavigationLink(destination: LocationView()){
                    Text("LocationView")
                }
            }
//            NavigationLink(destination: RecordChartView()){
//                Text("RecordChartView")
//            }
        }
        .onAppear(){
            print(modelContext.sqliteCommand)
        }
        
    }
}

#Preview {
    TestView()
}
