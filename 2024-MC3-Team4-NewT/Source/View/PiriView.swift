//
//  PiriView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/21/24.
//
import SwiftUI

struct PiriView: View {
    
    
    var body: some View {
        VStack(spacing:20){
            NavigationLink(destination: FindSpotView()){
                Text("spot")
            }
            NavigationLink(destination: APIView()){
                Text("API")
            }
            NavigationLink(destination: EmbededView()){
                Text("Embeded")
            }
            NavigationLink(destination: WindyView()){
                Text("Windy")
            }
            
        }
    }
    
}



