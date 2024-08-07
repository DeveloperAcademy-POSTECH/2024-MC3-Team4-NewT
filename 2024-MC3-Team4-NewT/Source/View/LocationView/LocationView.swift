import Foundation
import SwiftUI

struct LocationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel = RecordChartViewModel()

    @Binding var selectedItem: String
    var body: some View {
        ZStack{
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            VStack(spacing: 0){
                Divider()
                    .background(Color(.clear))
                HStack(spacing: 0){
                    VStack(alignment: .leading, spacing: 0){
                        ForEach(regions) { region in
                            HStack(spacing: 0){
                                Button {
                                    viewModel.selectedRegion = region
                                    viewModel.isSelectButton = true
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
                    
                    ZStack(alignment: .leading){
                        Color.white
                        if let region = viewModel.selectedRegion {
                            VStack(alignment: .leading, spacing: 0){
                                ForEach(region.items, id: \.self) { item in
                                    HStack{
                                        Button {
                                            viewModel.selectedItem = item
                                            viewModel.isSelectButton = false
                                           
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
            
        }.navigationTitle("지역선택")
    }
}
