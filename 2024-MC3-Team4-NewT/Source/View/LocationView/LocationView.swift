import Foundation
import SwiftUI

struct LocationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel = RecordChartViewModel()

    @Binding var selectedItem: String
    
    // UserDefaults 키 상수
    private let selectedRegionKey = "selectedRegion"
    private let selectedItemKey = "selectedItem"
    
    var body: some View {
        ZStack{
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            VStack(spacing: 0){
                Divider()
                    .background(Color(.clear))
                HStack(spacing: 0){
                    // 왼쪽 지역 목록 (순서가 고정됨)
                    VStack(alignment: .leading, spacing: 0){
                        ForEach(regions) { region in
                            HStack(spacing: 0){
                                Button {
                                    viewModel.selectedRegion = region
                                    viewModel.isSelectButton = true
                                    saveSelection()
                                } label: {
                                    ZStack(alignment: .leading){
                                        Spacer()
                                            .frame(width: 150, height: 57)
                                            .background(viewModel.selectedRegion?.id == region.id ? Color(viewModel.selectedItemBackgroundColor) : Color(.systemGroupedBackground))
                                        Text(region.name)
                                            .font(.SubheadingSemiBold)
                                            .padding(.vertical, 15)
                                            .padding(.leading)
                                            .foregroundColor(viewModel.selectedRegion?.id == region.id ? Color(viewModel.selectedItemColor) : Color.black.opacity(0.5) )
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                    .frame(width: 150)
                    
                    // 오른쪽 항목 목록 (선택된 지역이 첫 번째로 나타남)
                    ZStack(alignment: .leading){
                        Color.white
                        if let region = viewModel.selectedRegion {
                            VStack(alignment: .leading, spacing: 0){
                                ForEach(region.items, id: \.self) { item in
                                    HStack{
                                        Button {
                                            viewModel.selectedItem = item
                                            viewModel.isSelectButton = false
                                            saveSelection()
                                        } label: {
                                            ZStack(alignment: .leading){
                                                Spacer()
                                                    .frame(height: 57)
                                                Text(item)
                                                    .font(.Body1Medium)
                                                    .padding(.top)
                                                    .padding(.bottom, 17)
                                                    .padding(.leading)
                                                    .foregroundColor(viewModel.selectedItem == item ? Color(viewModel.selectedItemColor) : Color.black.opacity(0.5) )
                                            }
                                            Spacer()
                                        }
                                    }
                                }
                                Spacer()
                            }
                        }
                    }
                }
                
                Divider()
                    .padding(.bottom, 8)
                
                Button{
                    selectedItem = viewModel.selectedItem
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    ZStack {
                        if viewModel.isSelectButton {
                            Color("backgroundGray")
                                .frame(height: 55)
                                .cornerRadius(36)
                        }
                        else {
                            Color("surfBlue")
                                .frame(height: 55)
                                .cornerRadius(36)
                        }
                        HStack{
                            Text("선택 완료")
                                .font(.SubheadingBold)
                                .foregroundColor(Color.white)
                        }
                    }
                    .padding(.horizontal)
                }.disabled(viewModel.isSelectButton)
                
            }
            
        }
        .navigationTitle("지역선택")
        .onAppear {
            loadSelection()
        }
    }
    
    // selectedItem에 해당하는 지역을 반환하는 함수
    func regionForSelectedItem(_ item: String) -> Region? {
        for region in regions {
            if region.items.contains(item) {
                return region
            }
        }
        return nil
    }
    
    // 선택된 지역과 항목을 UserDefaults에 저장하는 함수
    func saveSelection() {
        if let selectedRegion = viewModel.selectedRegion {
            UserDefaults.standard.set(selectedRegion.name, forKey: selectedRegionKey)
        }
        UserDefaults.standard.set(viewModel.selectedItem, forKey: selectedItemKey)
    }
    
    // UserDefaults에서 저장된 선택 항목을 불러오는 함수
    func loadSelection() {
        if let savedRegionName = UserDefaults.standard.string(forKey: selectedRegionKey),
           let savedItem = UserDefaults.standard.string(forKey: selectedItemKey) {
            if let region = regions.first(where: { $0.name == savedRegionName }) {
                viewModel.selectedRegion = region
                viewModel.selectedItem = savedItem
                viewModel.isSelectButton = false
            }
        }
    }
}
