//
//  TestView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/21/24.
//

import SwiftUI

struct TestView: View {
    @Environment(\.modelContext) private var modelContext
    @State var showMainTestView1 = false
    @State var showMainTestView2 = false
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 20.0){
    //            FitChartView()
                NavigationLink(destination: PiriView()){
                    Text("파이리")
                }
                NavigationLink(destination: JaneView()){
                    Text("제인")
                }
    //            NavigationLink(destination: SisiView()){
    //                Text("씨씨")
    //            }
//                NavigationLink(destination: NadaView()){
//                    Text("나다")
//                }
                NavigationLink(destination: FitChartView()){
                    Text("FitChartView")
                }
            }
//            NavigationLink(destination: RecordChartView()){
//                Text("RecordChartView")
//            }
            Button(action: {
                showMainTestView1 = true
            }) {
                Text("Go to MainTestView")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .fullScreenCover(isPresented: $showMainTestView1) {
                MainView()
            }
            Button(action: {
                showMainTestView2 = true
            }) {
                Text("SiSi View")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .fullScreenCover(isPresented: $showMainTestView2) {
                SisiView()
            }
        }
        .onAppear(){
            print(modelContext.sqliteCommand)
        }
        
    }
}

#Preview {
    TestView()
}
