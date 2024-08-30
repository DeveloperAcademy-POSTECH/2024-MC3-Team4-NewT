//
//  NewRecordCreateViewModel.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/30/24.
//

import SwiftUI
import SwiftData

class NewRecordCreateViewModel: ObservableObject {
    @Published var SDDailySurfingValues: [DailySurfingValues] = [] // 데이터를 저장할 배열
    
    
    // 데이터를 가져오는 메서드
    func fetchDailySurfingValues(modelContext: ModelContext) {
        do {
            // DailySurfingValues를 time 속성으로 정렬하여 가져옴
            let descriptor = FetchDescriptor<DailySurfingValues>(sortBy: [SortDescriptor(\.time)])
            self.SDDailySurfingValues = try modelContext.fetch(descriptor)
            print("데이터를 성공적으로 불러왔습니다")
        } catch {
            print("DailySurfingValues를 가져오는 동안 오류 발생: \(error)")
        }
    }
}
