//
//  NewMainView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/27/24.
//
import SwiftUI

struct NewMainView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                MainBackgroundImage()
                VStack {
                    MainRegionChoice()
                    MainTopView()
                }
               
            }
        }
    }
}

#Preview {
    NewMainView()
}
