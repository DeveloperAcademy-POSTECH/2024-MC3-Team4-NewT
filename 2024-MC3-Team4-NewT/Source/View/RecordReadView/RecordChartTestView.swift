//
//  RecordChartTestView.swift
//  2024-MC3-Team4-NewT
//
//  Created by siye on 8/5/24.
//

import Foundation
import SwiftUI
import SwiftData

struct RecordChartTestView: View {
    @Query private var surfingRecordOneData: [SurfingRecordOne]
    @ObservedObject var viewModel : RecordChartViewModel
    
    var body: some View {
        VStack(spacing: 0){
            ZStack{
                Rectangle()
                    .foregroundColor(Color("brightGray"))
                HStack(spacing: 50){
                    Text("시간")
                    Text("바람")
                    Text("파도")
                    Text("수온")
                    Text("날씨")
                }
                .font(.CaptionMedium)
                .foregroundColor(Color.black.opacity(0.6))
            }
            .frame(height: 20)
            
            ZStack(alignment: .top){
                Color.white
                VStack(spacing: 0){
                    ForEach(0..<viewModel.chartCounter, id: \.self) { index in
                        VStack(spacing: 0 ){
                            ZStack{
                                Color.clear
                                    .frame(height: 58)
                                HStack(spacing: 20){
                                    Text("\(index + viewModel.startHour)시")
                                        .font(.CaptionMedium)
                                        .foregroundColor(.black)
                                        .opacity(0.7)
                                    
                                    HStack(spacing: 5){
                                        Image(systemName: "paperplane")
                                            .foregroundColor(Color("iconSkyblue"))
                                        Text("3.3m/s")
                                            .font(.Body2Medium)
                                    }
                                    HStack(spacing: 5){
                                        Image(systemName: "paperplane.fill")
                                            .foregroundColor(Color("surfBlue"))
                                        VStack(spacing: 0){
                                            Text("0.2m")
                                                .font(.Body2Medium)
                                            Text("3.3m/s")
                                                .font(.CaptionMedium)
                                        }
                                    }
                                    VStack(spacing: 0){
                                        Text("28°C")
                                            .font(.Body2Medium)
                                        Image(systemName: "water.waves")
                                            .foregroundColor(Color("iconPurple"))
                                    }
                                    HStack(spacing: 5){
                                        Image(systemName: "cloud")
                                            .foregroundColor(.gray)
                                        Text("28°C")
                                            .font(.Body2Medium)
                                    }
                                }
                            }
                            
                            Divider()
                                .background(Color("surfBlue"))
                        }
                    }
                    
                }
            }
            .frame(height: 58*CGFloat(viewModel.chartCounter))

        }

    }
}

