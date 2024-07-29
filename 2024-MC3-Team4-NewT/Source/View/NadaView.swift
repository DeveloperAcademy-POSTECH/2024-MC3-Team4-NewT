//
//  NadaView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/21/24.
//

import SwiftUI

import SwiftUI

struct NadaView: View {
    var body: some View {
        VStack {
            
            // Grid
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()), // 시간
                    GridItem(.flexible()), // 바람
                    GridItem(.flexible()), // 파도
                    GridItem(.flexible()), // 수온
                    GridItem(.flexible())  // 날씨
                ], spacing: 10) {
                    // Column Titles
                    Text("시간")
                    Text("바람")
                    Text("파도")
                    Text("수온")
                    Text("날씨")
                    
                    // Sample Data Rows
                    ForEach(0..<10) { _ in
                        Text("00시")
                        VStack {
                            Image(systemName: "wind")
                            Text("3.3m/s")
                        }
                        VStack {
                            Image(systemName: "waveform.path.ecg")
                            Text("0.2m")
                        }
                        VStack {
                            Text("28°C")
                            Image(systemName: "waveform.path.ecg")
                        }
                        VStack {
                            Image(systemName: "cloud.rain")
                            Text("28°C")
                        }
                    }
                }
                .padding()
            }

            // Footer
            HStack {
                Button(action: {}) {
                    VStack {
                        Image(systemName: "chart.bar")
                        Text("파도차트")
                    }
                }
                .padding()
                .foregroundColor(.blue)
                
                Button(action: {}) {
                    VStack {
                        Image(systemName: "waveform.path.ecg")
                        Text("파도기록")
                    }
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .foregroundColor(.white)
                
                Button(action: {}) {
                    VStack {
                        Image(systemName: "doc.text")
                        Text("기록차트")
                    }
                }
                .padding()
                .foregroundColor(.blue)
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
        }
        .padding()
    }
}

#Preview {
    NadaView()
}
