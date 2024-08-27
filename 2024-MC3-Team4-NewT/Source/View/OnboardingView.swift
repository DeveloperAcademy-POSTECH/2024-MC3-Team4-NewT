//
//  OnboardingView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/11/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
//            MainView() // MainView로 전환
            NewMainView()
            
        } else {
            VStack {
                Image("Onboarding") // "Onboarding" 이미지
                    .resizable()
                    .scaledToFill() // 이미지 크기를 가로에 맞추고, 세로는 필요에 따라 자름
                    .frame(width: UIScreen.main.bounds.width) // 화면의 가로 크기에 맞춤
                    .clipped() // 잘려진 부분을 클립하여 보여줌
                
                
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
