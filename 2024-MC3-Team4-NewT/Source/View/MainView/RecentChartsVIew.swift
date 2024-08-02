//
//  RecentChartsVIew.swift
//  2024-MC3-Team4-NewT
//
//  Created by 김이예은 on 7/31/24.
//

import SwiftUI

struct RecentChartsVIew: View {
    var body: some View {
        VStack(spacing: 0){
            HStack{
                Text("최근 기록 차트")
                    .font(.Heading3Bold)
                    .foregroundColor(.white)
                Spacer()
                Button{
                    
                } label: {
                    HStack(alignment: .center, spacing: 2){
                        Text("모두 보기").font(.Body2SemiBold)
                        Image(systemName: "chevron.right")
                    }.foregroundColor(.white)
                }
            }
            .padding(.bottom, 8)
            
            VStack {
                HStack {
                    //맨 윗줄 들어가는 곳
                }
                
            }
            .cornerRadius(24)
        }.background{
            Image("MainViewBG")
        }
        
    }
}

#Preview {
    RecentChartsVIew()
}
