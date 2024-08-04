//
//  TabBarButton.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/5/24.
//

import SwiftUI

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
