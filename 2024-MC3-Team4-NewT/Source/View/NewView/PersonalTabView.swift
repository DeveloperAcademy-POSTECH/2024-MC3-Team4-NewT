//
//  NewFitChartView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/27/24.
//

import SwiftUI
import SwiftData

struct PersonalTabView: View {
    
    var body: some View {
        VStack(spacing: 0){
            //MARK: 메인뷰 상단 메뉴
            TabView{
                StatisticsView()
                RecentChartsView()
                PinChartsView()
            }
            .frame(maxHeight: 256)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            // .never 로 하면 배경 안보이고 .always 로 하면 인디케이터 배경 보입니다.
        }
        
    }
}




#Preview {
    PersonalTabView()
}
