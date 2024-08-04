//
//  TabBarBackup.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/5/24.
//
//import SwiftUI
//
//struct CustomTabBar: View {
//    @State private var selectedTab: Int = 0
//    @State private var isRecord: Bool = false
//    
//    var body: some View {
//        ZStack {
//            HStack{
//                Spacer()
//                ZStack(alignment: .top) {
//                    HStack {
//                        Spacer()
//                        TabBarButton(icon: ((selectedTab == 0) ? "chartBarXaxis" : "chartBarXaxis.gray"), label: "파도차트", isSelected: selectedTab == 0)
//                            .onTapGesture {
//                                selectedTab = 0
//                            }
//                        
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                        
//                        TabBarButton(icon: ((selectedTab == 2) ? "bookPages" : "bookPages.gray"), label: "기록 차트", isSelected: selectedTab == 2)
//                            .onTapGesture {
//                                selectedTab = 2
//                            }
//                        
//                        Spacer()
//                    }
//                    .frame(height: 60)
//                    .padding(.vertical, 10)
//                    .padding(.horizontal, 20)
//                    .background(
//                        Rectangle()
//                            .fill(.white)
//                    )
//                    Rectangle()
//                        .frame(height: 0.5) // 선의 두께, 0.33은 반영을 안해줘서 0.5로 설정
//                        .foregroundColor(.black.opacity(0.3))
//                }
//            }
//            
//            
//            //Floating Button
//            Button(action: {
//                
//            }, label: {
//                if !isRecord {
//                    ZStack{
//                        Circle()
//                            .fill(.surfBlue)
//                            .frame(width: 70, height: 70)
//                        
//                        VStack {
//                            Image("waterWaves")
//                                .font(.system(size: 24))
//                                .foregroundColor(.white)
//                                .padding(.bottom, 4)
//                            Text("파도기록")
//                                .font(.CaptionSemiBold)
//                                .foregroundColor(.white)
//                        }
//                    }
//                    .offset(y: -20)
//                    .onTapGesture {
//                        isRecord = true
//                    }
//                }
//                else {
//                    Spacer()
//                    //버튼 바뀌고 올라가는 애니메이션
//                    ZStack(alignment: .bottom) {
//                        Rectangle()
//                        .frame(height: 380)
//                        .foregroundColor(.white.opacity(0.7))
//                        .cornerRadius(24)
//                        .blur(radius: 40)
//                        Image("recordXButton")
//                            .offset(y: -20)
//                            .onTapGesture {
//                                isRecord = false
//                            }
//                    }
//                    
//                    
//                }
//            })
//        }
//        
//    }
//}
//
