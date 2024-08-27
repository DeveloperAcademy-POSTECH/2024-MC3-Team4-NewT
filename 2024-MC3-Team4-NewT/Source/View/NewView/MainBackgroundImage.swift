//
//  MainBackgroundImage.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/27/24.
//

import SwiftUI

struct MainBackgroundImage: View {
    var body: some View {
        GeometryReader { geometry in
            Image("MainViewBG")
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width, height: geometry.size.height)

        }
        .edgesIgnoringSafeArea(.all) // GeometryReader 자체는 Safe Area를 무시하지 않음
    }
}

#Preview {
    NewMainView()
}
