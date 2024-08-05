import Foundation
import SwiftUI
import SwiftData

struct RecordChartView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var surfingRecordOneData: [SurfingRecordOne]
    @ObservedObject var viewModel = RecordChartViewModel()

    var body: some View {
        ZStack{
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0){
                Button{
                    
                } label: {
                    HStack{
                        Text("포항 신항만 해변A ")
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
                
                ScrollView{
                    ForEach(surfingRecordOneData, id: \.id) { item in
                        ZStack(alignment: .top){
                            Color.white
                            VStack(spacing: 0){
                                VStack{
                                    HStack{
                                        Text(DateFormatterManager.shared.dateFormatter(from: item.surfingStartTime))
                                            .font(.SubheadingBold)
                                            .foregroundColor(Color("surfBlue"))
                                        Spacer()
                                        Button{
                                            withAnimation{
                                                viewModel.isEllipsisOnOff.toggle()
                                            }
                                        }label: {
                                            Image(systemName: "ellipsis")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 28)
                                                .foregroundColor(.black)
                                        }
                                        
                                    }
                                    HStack(spacing: 0){
                                        
                                        HStack(spacing: 0){
                                            HStack(spacing: 0){
                                                Image(systemName: "star.fill")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: 13)
                                                    .foregroundColor(Color("surfBlue"))
                                                Text(" \(item.evaluationValue)점, ")
                                                    .font(.Body2SemiBold)
                                                    .foregroundColor(.black.opacity(0.7))
                                                
                                                if(item.evaluationValue == 1){
                                                    Text("별로예요")
                                                        .font(.Body2Medium)
                                                        .foregroundColor(.black.opacity(0.7))
                                                }
                                                else if(item.evaluationValue  == 2){
                                                    Text("아쉬워요")
                                                        .font(.Body2Medium)
                                                        .foregroundColor(.black.opacity(0.7))
                                                }
                                                else if(item.evaluationValue  == 3){
                                                    Text("보통이에요")
                                                        .font(.Body2Medium)
                                                        .foregroundColor(.black.opacity(0.7))
                                                }
                                                else if(item.evaluationValue  == 4){
                                                    Text("만족해요")
                                                        .font(.Body2Medium)
                                                        .foregroundColor(.black.opacity(0.7))
                                                }
                                                else {
                                                    Text("최고예요")
                                                        .font(.Body2Medium)
                                                        .foregroundColor(.black.opacity(0.7))
                                                }
                                            }
                                            .padding(5)
                                            .background(.white.opacity(0.6))
                                            .cornerRadius(12)
                                            
                                        }
                                        Spacer()
                                        if(item.memo.isEmpty) {
                                            Button{
                                                viewModel.isID = item.id
                                                //메모 추가하기 눌렀을때 보이는 화면 만들어야함!!
                                                
                                            } label: {
                                                
                                                Text("메모 추가하기 ")
                                                    .font(.CaptionMedium)
                                                Image(systemName: "plus")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: 12)
                                            }
                                            .foregroundColor(Color.black.opacity(0.5))
                                        }
                                        
                                        else {
                                            Button{
                                                viewModel.ismemo.toggle()
                                                viewModel.isID = item.id
                                            } label: {
                                                
                                                Text("메모 확인하기 ")
                                                    .font(.CaptionMedium)
                                                Image(systemName: "chevron.right")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: 12)
                                            }
                                            .foregroundColor(Color.black.opacity(0.8))
                                            .sheet(isPresented: $viewModel.ismemo){
                                                ModalView(viewModel: viewModel)
                                                //halfModal 만들어야함!
                                            }
                                        }
                                        
                                    }
                                }
                                .padding(.top)
                                .padding(.bottom)
                                .padding(.horizontal)
                                .background(Color("backgroundSkyblue"))
                                
                                
                                RecordChartTestView(viewModel: viewModel)
                            }
                            
                            if viewModel.isEllipsisOnOff {
                                HStack{
                                    Spacer()
                                    ZStack{
                                        Rectangle()
                                            .foregroundColor(.white)
                                        VStack(alignment:.leading ,spacing: 0){
                                            Button{
                                                
                                            } label: {
                                                HStack{
                                                    Text("핀 고정")
                                                    Spacer()
                                                    Image(systemName: "pin")
                                                }
                                                .foregroundColor(.black)
                                                .frame(width: 218, height: 44)
                                                .padding(.leading)
                                            }
                                            
                                            Divider()
                                            Button{
                                                
                                            } label: {
                                                HStack{
                                                    Text("수정")
                                                    Spacer()
                                                    Image(systemName: "pencil")
                                                }
                                                .foregroundColor(.black)
                                                .frame(width: 218, height: 44)
                                                .padding(.leading)
                                            }
                                            
                                            Divider()
                                            Button{
                                                
                                            } label: {
                                                HStack{
                                                    Text("삭제")
                                                    Spacer()
                                                    Image(systemName: "trash")
                                                }
                                                .foregroundColor(.red)
                                                .frame(width: 218, height: 44)
                                                .padding(.leading)
                                            }
                                            
                                        }
                                    }
                                    .frame(width: viewModel.isEllipsisOnOff ? 250 : 0, height: viewModel.isEllipsisOnOff ? 132 : 0)
                                    .cornerRadius(12)
                                    .shadow(radius: 10)
                                    .padding(.top,47)
                                    .padding(.trailing, 16)
                                }
                                
                            }
                        }
                        .frame(height: 110+CGFloat((58 * viewModel.chartCounter)))
                        .cornerRadius(24)
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    
                    
                }
                
            }
        }
    }
}


#Preview {
    RecordChartView()
}
