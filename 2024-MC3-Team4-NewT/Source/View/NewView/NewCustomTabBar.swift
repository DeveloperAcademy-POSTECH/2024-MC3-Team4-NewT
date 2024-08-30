//
//  CustomTabBar.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/3/24.
//
import SwiftUI

struct NewCustomTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white .ignoresSafeArea(edges: .bottom)
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
            .background(
                Rectangle()
                    .fill(.white)
            )
            .ignoresSafeArea(edges: .bottom)
            
            Rectangle()
                .frame(height: 0.5) // 선의 두께, 0.33은 반영을 안해줘서 0.5로 설정
                .foregroundColor(.black.opacity(0.3))
                
            NavigationLink(destination: RecordCreateView()) {
                ZStack {
                    Circle()
                        .fill(Color(.surfBlue))
                        .frame(width: 70, height: 70)
                        .shadow(radius: 4)
                    
                    VStack {
                        Image(systemName: "water.waves")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                        Text("파도기록")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                }
                .offset(y: -20)
            }
        }.frame(height: 60)
        
        
        
    }
}
#Preview {
    NewCustomTabBar(selectedTab: .constant(0))
}
