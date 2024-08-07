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
    @ObservedObject var viewModel = RecordChartViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack{
                VStack {
                    if selectedTab == 0 {
                        VStack {
                            //                    if isHeaderVisible {
                            VStack {
                                NavigationLink(destination: LocationView(selectedItem: $viewModel.selectedItem)) {
                                    HStack(alignment: .center, spacing: 4){
                                        Text(viewModel.selectedItem)
                                            .font(.SubheadingSemiBold)
                                            .foregroundColor(.white)
                                        Image(systemName: "chevron.down")
                                            .foregroundColor(.white)
                                        Spacer()
                                    }
                                    .opacity(0.7)
                                    .padding(.vertical, 6)
                                }
                                
                            }.padding(.horizontal)
                            //                    }
                            FitChartView()
                                .padding(.horizontal)
                            MainChartView(isHeaderVisible: $isHeaderVisible)
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
                        .ignoresSafeArea(edges: .bottom)
                }
            }.background{
                Image("MainViewBG")
                    .edgesIgnoringSafeArea(.all)
            }
            
        }
        
    }
}

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
