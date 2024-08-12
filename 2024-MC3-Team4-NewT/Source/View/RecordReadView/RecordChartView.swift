import Foundation
import SwiftUI
import SwiftData

struct RecordChartView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var surfingRecordOneData: [SurfingRecordOne]
    @ObservedObject var viewModel = RecordChartViewModel()
    @State var isLocationSelected = false
    private let selectionKey = "selectionKey" 
    @State private var selectedItem: String = ""
    @State private var mappedItem: String = ""
    private let defaultItem = "포항 월포해변"
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    NavigationLink(destination: LocationView(isLocationSelected: $isLocationSelected)) {
                        HStack {
                            Text(selectedItem)
                                .font(.SubheadingSemiBold)
                            Image(systemName: "chevron.down")
                            Spacer()
                        }
                        .foregroundColor(.black).opacity(0.7)
                        .padding(.horizontal)
                    }
                    Spacer().frame(height: 8)
                    
                    CategoriesView(viewModel: viewModel)
                    
                    Spacer().frame(height: 16)
                    
                    ScrollView {
                        ForEach(surfingRecordOneData, id: \.id) { item in
                            RecordItemView(item: item, viewModel: viewModel)
                                .onAppear{
                                    print("큰 차트 item.id \(item.id)")
                                }
                                
                            
                        }
                        Spacer()
                            .frame(height: 60)
                    }
                }.padding(.top, 50)
            }
        }
        .onAppear{
            aaa()
        }
    }
    func aaa(){
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
            
        }
    }
}


