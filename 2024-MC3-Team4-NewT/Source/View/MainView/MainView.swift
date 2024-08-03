//
//  MainView.swift
//  2024-MC3-Team4-NewT
//
//  Created by 김이예은 on 7/31/24.
//

import Foundation
import SwiftUI
import SwiftData

struct MainView: View {
    var body: some View {
        NavigationStack {
            ZStack{
                VStack {
                    FitChartView()
                        .padding(.horizontal)
                    JaneView()
                }
                //여기에 탭바 넣으면 됩니다
            }
        }
        .background{
            Image("MainViewBG")
            .edgesIgnoringSafeArea(.all)
        }
    }
}
