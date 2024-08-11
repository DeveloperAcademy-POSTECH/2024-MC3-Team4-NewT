//
//  ChartHeaderView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/5/24.
//

import SwiftUI

struct ChartHeaderView: View {
    @ObservedObject var viewModel: RecordCreateViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(destination: FirebaseSDView()){
                Text(DateFormatterManager.shared.date(from: viewModel.selectedDate))
                    .font(.SubheadingBold)
                    .foregroundStyle(Color("surfBlue"))
                    .padding(.vertical, 8)
            }
            ZStack {
                Rectangle()
                    .frame(height: 20)
                    .foregroundColor(Color(.systemGroupedBackground))
                HStack(spacing: 50) {
                    Text("시간")
                    Text("바람")
                    Text("파도")
                    Text("수온")
                    Text("날씨")
                }
                .font(.CaptionMedium)
                .foregroundColor(Color(.black).opacity(0.5))
            }
        }
    }
}
