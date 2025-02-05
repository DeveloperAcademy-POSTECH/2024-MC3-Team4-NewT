import Foundation
import SwiftUI
import SwiftData
struct LocationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // 현재 뷰의 presentation 상태를 제어하기 위한 환경 변수
    @ObservedObject var viewModel = RecordChartViewModel() // 뷰와 관련된 데이터를 관리하기 위한 ViewModel
    
    // UserDefaults 키 상수
    private let selectionKey = "selectionKey" // 선택된 지역과 항목을 함께 저장하기 위한 UserDefaults 키
    
    @State private var selectedRegion: Region? // 선택된 지역을 저장하기 위한 상태 변수
    @State private var selectedRegionItem: String? // 선택된 지역 내 항목을 저장하기 위한 상태 변수
    @Binding var isLocationSelected: Bool
    
    @Query(filter:#Predicate<ChartRow>{ item in
        item.surfingRecordStartTime == nil
        
    },sort: \ChartRow.time) var chartRow: [ChartRow]
    @Environment(\.modelContext) private var modelContext
    var fbo = FirebaseObservable()
    @State private var mappedItem: String = ""
    
    var body: some View {
        ZStack {
            // 배경 색상을 설정하고, 전체 화면 영역을 채우도록 설정
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Divider()
                    .background(Color(.clear)) // 구분선을 투명하게 설정

                HStack(spacing: 0) {
                    // 왼쪽 지역 목록 (순서가 고정됨)
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(regions) { region in
                            HStack(spacing: 0) {
                                Button {
                                    // 지역을 선택했을 때 해당 지역을 상태 변수에 저장하고 UserDefaults에 저장
                                    selectedRegion = region
                                    selectedRegionItem = nil
                                    saveSelection()
                                } label: {
                                    ZStack(alignment: .leading) {
                                        // 선택된 지역에 따라 배경 색상을 다르게 설정
                                        Spacer()
                                            .frame(width: 150, height: 57)
                                            .background(selectedRegion?.id == region.id ? Color(viewModel.selectedItemBackgroundColor) : Color(.systemGroupedBackground))
                                        // 지역 이름을 표시
                                        Text(region.name)
                                            .font(.SubheadingSemiBold)
                                            .padding(.vertical, 15)
                                            .padding(.leading)
                                            .foregroundColor(selectedRegion?.id == region.id ? Color(viewModel.selectedItemColor) : Color.black.opacity(0.5))
                                    }
                                }
                            }
                        }
                        Spacer() // 남은 공간을 차지하는 Spacer
                    }
                    .frame(width: 150) // 지역 목록의 너비를 설정
                    
                    // 오른쪽 항목 목록 (선택된 지역이 첫 번째로 나타남)
                    ZStack(alignment: .leading) {
                        Color.white // 항목 목록의 배경 색상을 흰색으로 설정
                        if let region = selectedRegion {
                            VStack(alignment: .leading, spacing: 0) {
                                ForEach(region.items, id: \.self) { item in
                                    HStack {
                                        Button {
                                            // 항목을 선택했을 때 해당 항목을 상태 변수에 저장하고 UserDefaults에 저장
                                            selectedRegionItem = item
                                            saveSelection()
                                        } label: {
                                            ZStack(alignment: .leading) {
                                                Spacer()
                                                    .frame(height: 57)
                                                // 항목 이름을 표시
                                                Text(item)
                                                    .font(.Body1Medium)
                                                    .padding(.top)
                                                    .padding(.bottom, 17)
                                                    .padding(.leading)
                                                    .foregroundColor(selectedRegionItem == item ? Color(viewModel.selectedItemColor) : Color.black.opacity(0.5))
                                            }
                                            Spacer() // 남은 공간을 차지하는 Spacer
                                        }
                                    }
                                }
                                Spacer() // 남은 공간을 차지하는 Spacer
                            }
                        }
                    }
                }
                
                Divider()
                    .padding(.bottom, 8) // 구분선 아래에 약간의 여백 추가

                Button {
                    Task {
                            await saveSelection() // MainActor에서 실행되는 것이 안전함

                            // 매핑된 값 설정
                            if let mappedValue = beachToEnglishMap["\(selectedRegionItem ?? "포항 월포해변")"] {
                                await MainActor.run {
                                    mappedItem = mappedValue
                                }
                            } else {
                                await MainActor.run {
                                    mappedItem = ""
                                }
                            }
                            print("맵핑데이터:\(mappedItem)")

                            // 조건에 따라 모델 컨텍스트에서 ChartRow 삭제
                            for item in chartRow {
                                if let aa = item.surfingRecordStartTime {
                                    print("\(aa):통과")
                                } else {
                                    await MainActor.run {
                                        modelContext.delete(item)
                                    }
                                }
                            }

                            // Firebase에서 데이터 가져오기 (비동기 작업이므로 MainActor에서 벗어나도 괜찮음)
                            if mappedItem == "wolpo" {
                                fbo.fetchFirebase(modelContext: modelContext, collectionName: "wolpo", chartRow: chartRow)
                            } else {
                                fbo.fetchFirebase(modelContext: modelContext, collectionName: "jungmun", chartRow: chartRow)
                            }

                            // UI 상태 업데이트
                            await MainActor.run {
                                isLocationSelected = true
                                presentationMode.wrappedValue.dismiss() // 뷰를 닫음
                            }
                        }
                } label: {
                    ZStack {
                        // 선택된 항목이 없으면 버튼을 비활성화 (회색), 있으면 활성화 (파란색)
                        Color((selectedRegion != nil && selectedRegionItem != nil) ? "surfBlue" : "backgroundGray")
                            .frame(height: 55)
                            .cornerRadius(36)
                        HStack {
                            // 버튼의 텍스트를 표시
                            Text("선택 완료")
                                .font(.SubheadingBold)
                                .foregroundColor(Color.white)
                        }
                    }
                    .padding(.horizontal)
                }
                .disabled(selectedRegionItem == nil) // 선택된 항목이 없으면 버튼을 비활성화
                
            }
        }
        .navigationTitle("지역선택") // 네비게이션 바의 제목 설정
        .onAppear {
            // 뷰가 나타날 때 UserDefaults에서 이전에 저장된 선택 항목을 불러옴
            loadSelection()
        }
    }
    
    // 선택된 지역과 항목을 UserDefaults에 저장하는 함수
    func saveSelection() {
        if let selectedRegion = selectedRegion, let selectedRegionItem = selectedRegionItem {
            let combinedValue = "\(selectedRegion.name) \(selectedRegionItem)"
            UserDefaults.standard.set(combinedValue, forKey: selectionKey)
            print("저장된 값: \(combinedValue)")
        }
    }
    
    // UserDefaults에서 저장된 선택 항목을 불러오는 함수
    func loadSelection() {
        if let combinedValue = UserDefaults.standard.string(forKey: selectionKey) {
            let components = combinedValue.split(separator: " ", maxSplits: 1) // 첫 번째로만 분리
            if components.count == 2 {
                let itemName = String(components[1])
                
                selectedRegion = regions.first(where: { $0.items.contains(itemName) })
                selectedRegionItem = itemName
                print("불러온 값: \(combinedValue)")
            }
        }
    }
}
