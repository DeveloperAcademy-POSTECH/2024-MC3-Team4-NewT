import SwiftUI
import SwiftData

struct CategoriesView: View {
    @Query private var surfingRecordOneData: [OldSurfingRecordOne]
    @ObservedObject var viewModel = RecordChartViewModel()
    
    var body: some View {
        HStack{
            Spacer()
                .frame(width: 25)
            ForEach(0..<2) { index in
                Button {
                    viewModel.categoryIndex = index
                } label: {
                    if (index == 0){
                        Text("전체")
                    }
                    else if (index == 1){
                        Text("핀 고정")
                    }
//                    else if (index == 2){
//                        Text("날짜 선택")
//                    }
//                    else if (index == 3){
//                        HStack(spacing: 0){
//                            Text("별점 ")
//                            Image(systemName: "chevron.down")
//                        }
//                    }
//                    else{
//                        HStack(spacing: 0){
//                            Text("최신순 ")
//                            Image(systemName: "chevron.down")
//                        }
//                    }
                }.font(.Body2Medium)
                    .foregroundColor(viewModel.categoryIndex == index ? Color.white : Color.black)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(viewModel.categoryIndex == index ? Color("surfBlue") : Color.white)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black.opacity(0.15), lineWidth: 0.75)
                    )
                
            }
            Spacer()
        }
    }
}
