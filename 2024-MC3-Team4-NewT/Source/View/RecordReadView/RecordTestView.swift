//
//  SurfingRecordListView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/5/24.
//

import SwiftUI
import SwiftData

struct RecordTestView: View {
    @Query(sort: \SurfingRecordOne.surfingStartTime) var surfingRecords: [SurfingRecordOne]
    
    var body: some View {
        NavigationView {
            List(surfingRecords) { record in
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(DateFormatterManager.shared.date(from: record.surfingStartTime))")
                        .font(.headline)
                    Text("\(record.evaluationValue)점")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    Text(record.memo)
                        .font(.body)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("서핑 기록 리스트")
        }
    }

}

#Preview {
    RecordTestView()
}

