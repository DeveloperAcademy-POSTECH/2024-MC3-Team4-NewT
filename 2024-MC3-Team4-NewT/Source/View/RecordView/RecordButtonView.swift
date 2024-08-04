//
//  RecordButtonView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/5/24.
//

import SwiftUI
import SwiftData

struct RecordButtonView: View {
    @Binding var isMemo: Bool
    @Binding var heightSize: CGFloat
    let startTime: Date
    let stopTime: Date
    let memo: String
    let memoLimit: Int
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        Button{
            isMemo.toggle()
            modelContext.insert(SurfingRecordOne(surfingStartTime: startTime, surfingEndTime: stopTime, charts: [], evaluationValue: memoLimit, memo: memo))
            
            if isMemo {
                heightSize = 245.0
            }
            else {
                heightSize = 322.0
            }
            
        } label: {
            ZStack {
                Color("surfBlue")
                    .frame(height: 51)
                    .cornerRadius(36)
                HStack{
                    Text("기록 저장")
                        .font(.SubheadingBold)
                        .foregroundColor(Color.white)
                }
            }
            .padding(.horizontal)
            
        }
    }
}

