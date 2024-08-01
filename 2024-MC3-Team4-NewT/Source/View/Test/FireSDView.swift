//
//  FireSDView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/2/24.
//
import SwiftUI
import SwiftData

struct FirebaseSDView: View {
    @Environment(\.modelContext) var modelContext
    var fbo = FirebaseObservable()
    var sdo = SwiftDataObservable()
    @Query(sort: \ChartRow.time) var chartRow: [ChartRow]
    
    var body: some View {
        NavigationView {
            VStack {
                List(chartRow, id: \.self) { item in
                    VStack(alignment: .leading) {
                        Text("시간: \(formattedTime(item.time))")
                        Text("온도: \(item.surfingValues.airTemperature)")
                        Text("파주기: \(item.surfingValues.wavePeriod)")
                    }
                }
            }
            .navigationTitle("FirebaseSDView") // 뷰의 타이틀을 추가
            .onAppear {
                fbo.fetchFirebase(modelContext: modelContext, collectionName: "pohang", chartRow: chartRow) // fbo.items에 결과값 생성됨
            }
        }
    }
    
    // time 문자열을 원하는 형식으로 변환하는 함수
    func formattedTime(_ time: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // 입력 형식이 같다면 변환 없이 바로 반환 가능
        inputFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        if let date = inputFormatter.date(from: time) {
            // 입력된 문자열이 이미 "yyyy-MM-dd HH:mm:ss" 형식이면 변환 없이 사용
            return inputFormatter.string(from: date)
        } else {
            // 입력된 문자열이 다른 형식이라면 변환 로직 추가 가능
            return time // 일단 원래 문자열을 반환
        }
    }
}

#Preview {
    FirebaseSDView()
}
