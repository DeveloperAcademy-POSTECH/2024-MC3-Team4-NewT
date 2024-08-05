//
//  RecordButtonView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/5/24.
//

import SwiftUI
import SwiftData

struct RecordButtonView: View {
    
    @Environment(\.modelContext) var modelContext
    @ObservedObject var viewModel : RecordCreateViewModel
    
    var body: some View {
        Button{
            viewModel.isMemo.toggle()
            modelContext.insert(SurfingRecordOne(surfingStartTime: viewModel.startTime, surfingEndTime: viewModel.stopTime, charts: [], evaluationValue: viewModel.memoLimit, memo: viewModel.memo))
            
            if viewModel.isMemo {
                viewModel.heightSize = 245.0
            }
            else {
                viewModel.heightSize = 322.0
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

