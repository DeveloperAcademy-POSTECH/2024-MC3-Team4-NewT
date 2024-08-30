//
//  NewRecordCreateView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/30/24.
//
import SwiftUI
import SwiftData

struct NewRecordCreateView: View {
    // SwiftData의 모델 컨텍스트를 환경에서 가져옴
    @Environment(\.modelContext) var modelContext
    
    // ViewModel 인스턴스 생성 및 관찰
    @ObservedObject var oldViewModel = RecordCreateViewModel()
    @ObservedObject var newViewModel = NewRecordCreateViewModel()
    // 차트 데이터 필터링에 사용될 Observable 인스턴스 생성
    var cro = ChartRecordObservable()
    
    var body: some View {
        ZStack(alignment: .top) {
            // 배경색 설정
            Color(.systemGroupedBackground)
                .ignoresSafeArea()  // 안전 영역을 무시하고 전체 화면에 적용
            
            VStack(spacing: 0) {
                ScrollView {
                    VStack {
                        ZStack(alignment: .top) {
                            Color.white  // 섹션의 배경을 흰색으로 설정
                            VStack(spacing: 0) {
                                // 시간 선택기 뷰
                                TimePickerView(viewModel: oldViewModel)
                                
                                Divider()  // 구분선 추가
                                    .padding(.leading)
                                
                                // 차트 헤더 뷰
                                ChartHeaderView(viewModel: oldViewModel)
                                
                                // 차트 뷰
                                NewRecordCreateChartView(oldViewModel: oldViewModel, newViewModel: newViewModel
                                    
                                )
                            }
                        }
                        .cornerRadius(24)  // 모서리를 둥글게 설정
                        .padding(.horizontal)  // 좌우 여백 추가
                        
                        // 평가 뷰
                        EvaluationView(
                            viewModel: oldViewModel
                        )
                        .frame(height: oldViewModel.heightSize)  // 높이 설정
                        .cornerRadius(24)  // 모서리를 둥글게 설정
                        .padding(.horizontal)  // 좌우 여백 추가
                    }
                }
                .scrollDisabled(oldViewModel.isMemo)  // 메모 모드에서는 스크롤 비활성화
                .padding(.bottom)  // 하단 여백 추가
                
                // 기록 버튼 뷰
                RecordButtonView(
                    viewModel: oldViewModel,
                    observable: cro
                )
                
                Spacer()  // 남은 공간을 채워줌
            }
        }
        .navigationTitle("파도 기록")  // 네비게이션 타이틀 설정
        .onAppear {
            // 뷰가 나타날 때 ViewModel의 데이터를 초기화
            oldViewModel.resetData()
        }
    }
}
