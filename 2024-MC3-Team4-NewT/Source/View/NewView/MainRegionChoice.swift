//
//  MainRegionChoice.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/27/24.
//

import SwiftUI

struct MainRegionChoice: View {
    @State var opacityValue = 0.8
    var body: some View {
        // TODO: NavigationLink를 넣자
        HStack(alignment: .center, spacing: 4) {
            Text("포항 월포해변")
                .font(.SubheadingSemiBold)
                .foregroundColor(.white)
                .opacity(opacityValue)
            Image(systemName: "chevron.down")
                .foregroundColor(.white)
                .opacity(opacityValue)
            Spacer()
        }
        .padding(.horizontal)
        Spacer()
    }
}

#Preview {
    NewMainView()
}
