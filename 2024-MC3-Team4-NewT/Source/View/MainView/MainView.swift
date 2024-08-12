//
//  MainView.swift
//  2024-MC3-Team4-NewT
//
//  Created by 김이예은 on 7/31/24.
//
import Foundation
import SwiftUI
import SwiftData

struct MainView: View {
    @State private var scrollOffset: CGFloat = 0 // 스크롤 오프셋 상태 변수
    @State var isHeaderVisible: Bool = true // 헤더 가시성 상태 변수
    @State var selectedTab: Int = 0
    @State private var selectedItem: String = "" // 선택된 항목을 저장하기 위한 상태 변수
    @State private var mappedItem: String = "" // 매핑된 항목을 저장하기 위한 상태 변수
    @State var isLocationChanged = false
//    private let selectedItemKey = "selectedItem" // UserDefaults 키 상수
    private let selectionKey = "selectionKey" // 선택된 지역과 항목을 함께 저장하기 위한 UserDefaults 키
    private let defaultItem = "포항 월포해변" // 기본 항목
    var fbo = FirebaseObservable()
    @Query(filter:#Predicate<ChartRow>{ item in
        item.surfingRecordStartTime == nil
        
    },sort: \ChartRow.time) var chartRow: [ChartRow]
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            ZStack {
                Image("MainViewBG")
                    .edgesIgnoringSafeArea(.all)
                if selectedTab == 0 {
                    VStack {
                        VStack {
                            // LocationView로 이동하는 버튼
                            NavigationLink(destination: LocationView(isLocationSelected: $isLocationChanged)) {
                                HStack(alignment: .center, spacing: 4){
                                    Text(selectedItem.isEmpty ? "Select an Item" : selectedItem) // 선택된 항목을 표시
                                        .font(.SubheadingSemiBold)
                                        .foregroundColor(.white)
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                                .opacity(0.7)
                                Spacer()
                            }.padding(.vertical, 6)
                        }.padding(.horizontal)

                        FitChartView()
                            .padding(.horizontal)
                        MainChartView(isHeaderVisible: $isHeaderVisible)
                    }.padding(.top, 50)
                }
                else if selectedTab == 2 {
                    RecordChartView()
                }
                Spacer()
                VStack {
                    Spacer()
                    CustomTabBar(selectedTab: $selectedTab)
                        .ignoresSafeArea(edges: .bottom)
                }
            }.background {
                Image("MainViewBG")
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            loadSelectedItem() // 뷰가 나타날 때 UserDefaults에서 선택된 항목을 불러옴

        }
        .onChange(of:isLocationChanged){
            loadSelectedItem()
            isLocationChanged = false
        }
    }
    
    // UserDefaults에서 selectedItem을 불러오고 없으면 기본값을 설정하는 함수
    private func loadSelectedItem() {
        if let savedItem = UserDefaults.standard.string(forKey: selectionKey) {
            let components = savedItem.split(separator: " ", maxSplits: 1) // 첫 번째로만 분리
            if components.count == 2 {
                let regionName = String(components[0])
                let itemName = String(components[1])

                
                
                selectedItem = itemName
                // 매핑된 값이 존재하면 mappedItem에 저장, 그렇지 않으면 빈 문자열로 초기화
                if let mappedValue = beachToEnglishMap["\(itemName)"] {
                    mappedItem = mappedValue
                } else {
                    mappedItem = ""
                }
            }
            
            print("로드:\(selectedItem), 매핑된 값:\(mappedItem)")
        } else {
            // UserDefaults에 값이 없으면 기본값 설정
            selectedItem = defaultItem
            if let defaultMappedValue = beachToEnglishMap[defaultItem] {
                mappedItem = defaultMappedValue
            } else {
                mappedItem = ""
            }
            UserDefaults.standard.set(defaultItem, forKey: selectionKey) // 기본값을 UserDefaults에 저장
            fbo.fetchFirebase(modelContext: modelContext, collectionName: "wolpo", chartRow: chartRow)
        }
    }
}
