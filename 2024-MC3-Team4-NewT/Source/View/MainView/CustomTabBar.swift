//
//  CustomTabBar.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/3/24.
//
import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    @State private var isRecord: Bool = false
    @State private var recording: Bool = false
    @State private var isShowingSplash: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white .ignoresSafeArea(edges: .bottom).frame(height: 90)
            HStack(alignment:.top) {
                Spacer()
                TabBarButton(
                    icon: (selectedTab == 0 ? "chartBarXaxis" : "chartBarXaxis.gray"),
                    label: "파도차트",
                    isSelected: selectedTab == 0)
                .onTapGesture {
                    selectedTab = 0
                }
                
                Spacer()
                Spacer()
                Spacer()
                
                TabBarButton(
                    icon: (selectedTab == 2 ? "bookPages" : "bookPages.gray"),
                    label: "기록차트",
                    isSelected: selectedTab == 2)
                .onTapGesture {
                    selectedTab = 2
                }
                
                Spacer()
            }
            .frame(height: 80)
            .padding(.horizontal, 20)
            .padding(.bottom,30)
            .background(
                Rectangle()
                    .fill(.white)
            )
            .ignoresSafeArea(edges: .bottom)
            
            Rectangle()
                .frame(height: 0.5) // 선의 두께, 0.33은 반영을 안해줘서 0.5로 설정
                .foregroundColor(.black.opacity(0.3))
            
            if !isRecord {
                if recording {
                    Image("surfingingButton")
                        .onTapGesture {
                            isRecord = true
                        }
                } else {
                    ZStack{
                        Circle()
                            .fill(.surfBlue)
                            .frame(width: 70, height: 70)
                        
                        VStack {
                            Image("waterWaves")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .padding(.bottom, 4)
                            Text("기록하기")
                                .font(.CaptionSemiBold)
                                .foregroundColor(.white)
                        }
                    }
                    .offset(y: -20)
                    .onTapGesture {
                        isRecord = true
                    }
                }
            }
            else {
                //                    Spacer()
                VStack(alignment: .center) {
                    Button {
                        print("서핑 시작 눌림")
                        //스플래시 뷰 3초동안 나오게
                        
                    } label: {
                        if recording {
                            NavigationLink(destination: RecordCreateView()) {
                                Image("surfingCancelButton")
                                    
                            }.onTapGesture {
                                self.isRecord = false
                            }
//                            .onTapGesture {
//                                self.recording = false
//                                self.isRecord = false
//                            }
                        } else {
                            Image("surfingStartButton")
                                .onTapGesture {
                                    withAnimation {
                                        isShowingSplash = true
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        isShowingSplash = false
                                    }
                                    self.isRecord = false
                                    self.recording = true
                                    
                                }
                        }
                    }.padding(.bottom, 20)
                    
                        if recording == true {
                            Image("cancelRecordButton").padding(.bottom, 29)
                                .onTapGesture {
                                    self.recording = false
                                    self.isRecord = false
                                }
                        } else {
                            NavigationLink(destination: RecordCreateView()) {
                                Image("straightRecordButton").padding(.bottom, 29)
                            }
                    }
                    
                    //버튼 바뀌고 위에 버튼 추가되는 애니메이션 넣어야 함
                    ZStack(alignment: .bottom) {
                        Image("recordXButton")
                            .offset(y: -20)
                            .onTapGesture {
                                isRecord = false
                            }
                    }
                }.frame(height: 150)
                    .padding(.top, -170)
            }
            if isShowingSplash == true {
                Image("interactionView")
            }
        }.ignoresSafeArea(.all)
    }
}


struct TabBarButton: View {
    var icon: String
    var label: String
    var isSelected: Bool
    
    var body: some View {
        VStack {
            
            Image("\(icon)")
                .font(.system(size: 24))
            Text(label)
                .font(.CaptionSemiBold)
            
        }
        .foregroundColor(isSelected ? Color.surfBlue : Color.gray)
    }
}

struct SplashView: View {
    var body: some View {
        Image("interactionView")
    }
}
