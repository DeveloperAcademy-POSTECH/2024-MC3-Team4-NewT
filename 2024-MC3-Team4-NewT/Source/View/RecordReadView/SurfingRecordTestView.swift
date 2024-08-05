//
//  SurfingRecordListView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/5/24.
//

import SwiftUI
import SwiftData

struct SurfingRecordTestView: View {
    @Query(sort: \SurfingRecordOne.surfingStartTime) var surfingRecords: [SurfingRecordOne]

    var body: some View {
        NavigationView {
            List(surfingRecords) { record in
                VStack(alignment: .leading, spacing: 8) {
                    Text("서핑 시작 시간: \(formattedDate(record.surfingStartTime))")
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

    // 날짜 형식을 변환해주는 함수
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "ko_kr")
        return formatter.string(from: date)
    }
}

#Preview {
    SurfingRecordTestView()
}

