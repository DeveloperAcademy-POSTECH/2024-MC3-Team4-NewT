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
    @State private var scrollOffset: CGFloat = 0 // 스크롤 오프셋 상태 변수
    @State var isHeaderVisible: Bool = true // 헤더 가시성 상태 변수
    @State var selectedTab: Int = 0
    
    var body: some View {
        NavigationStack {
            ZStack{
                VStack {
                    if selectedTab == 0 {
                        VStack {
                            //                    if isHeaderVisible {
                            VStack {
                                Button{
                                    print("지역 선택 버튼 눌림")
                                }label: {
                                    HStack(alignment: .center, spacing: 4){
                                        Text("포항 신항만 해변A")
                                            .font(.SubheadingSemiBold)
                                            .foregroundColor(.white)
                                        Image(systemName: "chevron.down")
                                            .foregroundColor(.white)
                                    }
                                    .opacity(0.7)
                                    Spacer()
                                }
                                .padding(.vertical, 6)
                            }.padding(.horizontal)
                            //                    }
                            FitChartView()
                                .padding(.horizontal)
                            JaneView(isHeaderVisible: $isHeaderVisible)
                        }
                    }
                    else if (selectedTab == 2) {
                        RecordChartView()
                    }
                }
                Spacer()
                VStack{
                    Spacer()
                    //여기에 탭바 넣으면 됩니다
                    CustomTabBar(selectedTab: $selectedTab)
                }
            }
            
        }.ignoresSafeArea(edges: .bottom)
        .background{
            Image("MainViewBG")
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
