//
//  MainTopView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/27/24.
//

import SwiftUI

struct MainTopView: View {
    @State var selectedTab: Int = 0
    
    var body: some View {
        
        VStack {
            FitChartView()
            
        }
        
    }
}

#Preview {
    NewMainView()
}
