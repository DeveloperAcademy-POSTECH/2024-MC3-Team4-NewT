import Foundation
import SwiftUI
import SwiftData

struct RecordChartView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var surfingRecordOneData: [SurfingRecordOne]
    @ObservedObject var viewModel = RecordChartViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    NavigationLink(destination: LocationView(selectedItem: $viewModel.selectedItem)) {
                        HStack {
                            Text(viewModel.selectedItem ?? "포항 신항만해변A")
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
                        }
                    }
                }.padding(.top, 50)
            }
        }
    }
}


