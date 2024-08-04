//
//  PinChartsView.swift
//  2024-MC3-Team4-NewT
//
//  Created by 김이예은 on 7/31/24.
//

import SwiftUI

struct PinChartsView: View {
    var body: some View {
        VStack(spacing: 0){
            HStack{
                Text("고정 차트")
                    .font(.Heading3Bold)
                    .foregroundColor(.white)
                Spacer()
                Button{
                    
                } label: {
                    HStack(alignment: .center, spacing: 2){
                        NavigationLink(destination: RecordChartView()){
                            Text("모두 보기").font(.Body2SemiBold)
                        }
                        
                        Image(systemName: "chevron.right")
                    }.foregroundColor(.white)
                }
            }
            .padding(.bottom, 8)
            
            VStack {
                HStack {
                    Grid {
                        HStack(alignment: .center) {
                            Text("고정").font(.CaptionSemiBold)
                            Spacer()
                            Text("바람").font(.CaptionSemiBold)
                            Spacer()
                            Text("파도").font(.CaptionSemiBold)
                            Spacer()
                            Text("수온").font(.CaptionSemiBold)
                            Spacer()
                            Text("평가").font(.CaptionSemiBold)
                        }.foregroundColor(.black.opacity(0.5))
                            .padding(.horizontal, 24)
                            .padding(.vertical, 3)
                        Rectangle().frame(width: .infinity, height: 1).foregroundColor(.surfBlue.opacity(0.3))
                        HStack{
                            VStack {
                                Image("pinIcon")
                            }.padding(.leading, 8)
                            Spacer()
                            HStack {
                                Image("waveDirectionIcon")
                                Text("3.3m/s").font(.Body2Medium)
                            }.padding(.leading, -15)
                            Spacer()
                            HStack {
                                Image("swellDirectionIcon")
                                VStack {
                                    Text("0.2m").font(.Body2Medium)
                                    Text("3.4s").font(.CaptionMedium)
                                }
                            }.padding(.leading, -20)
                            Spacer()
                            VStack(spacing: 0) {
                                Text("28도").font(.Body2Medium)
                                Image("waterTemperate")
                            }.padding(.trailing, -8)
                            Spacer()
                            HStack(spacing: 4) {
                                Image("starIcon")
                                Text("5점").font(.Body2Medium)
                            }
                            
                        }.padding(.horizontal, 19)
                            .padding(.vertical, 6)
                        HStack{
                            VStack {
                                Image("pinIcon")
                            }.padding(.leading, 8)
                            Spacer()
                            HStack {
                                Image("waveDirectionIcon")
                                Text("3.3m/s").font(.Body2Medium)
                            }.padding(.leading, -15)
                            Spacer()
                            HStack {
                                Image("swellDirectionIcon")
                                VStack {
                                    Text("0.2m").font(.Body2Medium)
                                    Text("3.4s").font(.CaptionMedium)
                                }
                            }.padding(.leading, -20)
                            Spacer()
                            VStack(spacing: 0) {
                                Text("28도").font(.Body2Medium)
                                Image("waterTemperate")
                            }.padding(.trailing, -8)
                            Spacer()
                            HStack(spacing: 4) {
                                Image("starIcon")
                                Text("5점").font(.Body2Medium)
                            }
                            
                        }.padding(.horizontal, 19)
                            .padding(.vertical, 6)
                        HStack{
                            VStack {
                                Image("pinIcon")
                            }.padding(.leading, 8)
                            Spacer()
                            HStack {
                                Image("waveDirectionIcon")
                                Text("3.3m/s").font(.Body2Medium)
                            }.padding(.leading, -15)
                            Spacer()
                            HStack {
                                Image("swellDirectionIcon")
                                VStack {
                                    Text("0.2m").font(.Body2Medium)
                                    Text("3.4s").font(.CaptionMedium)
                                }
                            }.padding(.leading, -20)
                            Spacer()
                            VStack(spacing: 0) {
                                Text("28도").font(.Body2Medium)
                                Image("waterTemperate")
                            }.padding(.trailing, -8)
                            Spacer()
                            HStack(spacing: 4) {
                                Image("starIcon")
                                Text("5점").font(.Body2Medium)
                            }
                            
                        }.padding(.horizontal, 19)
                            .padding(.vertical, 6)
                    }
                }
            }
            .background(.white.opacity(0.5))
            .cornerRadius(24)
            //            .padding()
            Spacer()
        }
        
    }
}


#Preview {
    PinChartsView()
}
