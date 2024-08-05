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
    @State private var selectedTab: Int = 0
    @State private var isRecord: Bool = false
    var body: some View {
        NavigationStack {
            ZStack{
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
                VStack{
                    Spacer()
                    //여기에 탭바 넣으면 됩니다
                    ZStack {
                        HStack{
                            Spacer()
                            ZStack(alignment: .top) {
                                HStack {
                                    Spacer()
                                    TabBarButton(icon: ((selectedTab == 0) ? "chartBarXaxis" : "chartBarXaxis.gray"), label: "파도차트", isSelected: selectedTab == 0)
                                        .onTapGesture {
                                            selectedTab = 0
                                        }
                                    
                                    Spacer()
                                    Spacer()
                                    Spacer()
                                    
                                    TabBarButton(icon: ((selectedTab == 2) ? "bookPages" : "bookPages.gray"), label: "기록 차트", isSelected: selectedTab == 2)
                                        .onTapGesture {
                                            selectedTab = 2
                                        }
                                    
                                    Spacer()
                                }
                                .frame(height: 60)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(
                                    Rectangle()
                                        .fill(.white)
                                )
                                Rectangle()
                                    .frame(height: 0.5) // 선의 두께, 0.33은 반영을 안해줘서 0.5로 설정
                                    .foregroundColor(.black.opacity(0.3))
                            }
                        }
                        
                        
                        //Floating Button
                        Button(action: {
                            
                        }, label: {
                            if !isRecord {
                                ZStack{
                                    Circle()
                                        .fill(.surfBlue)
                                        .frame(width: 70, height: 70)
                                    
                                    VStack {
                                        Image("waterWaves")
                                            .font(.system(size: 24))
                                            .foregroundColor(.white)
                                            .padding(.bottom, 4)
                                        Text("파도기록")
                                            .font(.CaptionSemiBold)
                                            .foregroundColor(.white)
                                    }
                                }
                                .offset(y: -20)
                                .onTapGesture {
                                    isRecord = true
                                }
                            }
                            else {
                                Spacer()
                                //버튼 바뀌고 올라가는 애니메이션
                                ZStack{
                                    Rectangle()
                                    .frame(height: 380)
                                    .foregroundColor(.white.opacity(0.7))
                                    .cornerRadius(24)
                                    .blur(radius: 40)
                                    Image("recordXButton")
//                                        .offset(y: -20)
                                        .onTapGesture {
                                            isRecord = false
                                        }
                                }
                                
                                
                            }
                        })
                    }

                }
            }
            
        }
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
