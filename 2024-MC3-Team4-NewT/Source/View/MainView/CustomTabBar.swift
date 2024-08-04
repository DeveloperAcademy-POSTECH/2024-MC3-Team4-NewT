//
//  CustomTabBar.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/3/24.
//

import SwiftUI

struct CustomTabBar: View {
    @State private var selectedTab: Int = 1
    
    var body: some View {
        HStack {
            Spacer()
            TabBarButton(icon: "chart.bar", label: "파도차트", isSelected: selectedTab == 0)
                .onTapGesture {
                    selectedTab = 0
                }
            
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 70, height: 70)
                    .shadow(radius: 4)
                
                VStack {
                    Image(systemName: "waveform.path.ecg")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                    Text("파도기록")
                        .font(.caption)
                        .foregroundColor(.white)
                }
            }
            .offset(y: -20) // Move the circle up to align with the image
            .onTapGesture {
                selectedTab = 1
            }
            
            Spacer()
            
            TabBarButton(icon: "doc.text", label: "기록차트", isSelected: selectedTab == 2)
                .onTapGesture {
                    selectedTab = 2
                }
            
            Spacer()
        }
        .frame(height: 60)
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 39)
                .fill(Color(UIColor.systemGray6))
                .padding(.horizontal, 20)
                .padding(.vertical,10)
        )
    }
}




#Preview {
    CustomTabBar()
}
