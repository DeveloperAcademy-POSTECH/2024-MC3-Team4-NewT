import Foundation
import SwiftUI
import SwiftData

struct RecordChartView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var surfingRecordOneData: [SurfingRecordOne]
    
    @ObservedObject var viewModel = RecordChartViewModel()
//    @State var categories: Int = 0
//    @State var selectedDate = Date()
//    @State var startTime = Date()
//    @State var stopTime = Date()
//    @State var isEllipsisOnOff: Bool = false
//    @State var ismemo: Bool = false
//    
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
                
                HStack{
                    ForEach(0..<5) { index in
                        Button {
                            viewModel.categories = index
                        } label: {
                            if (index == 0){
                                Text("전체")
                            }
                            else if (index == 1){
                                Text("핀 고정")
                            }
                            else if (index == 2){
                                Text("날짜 선택")
                            }
                            else if (index == 3){
                                HStack(spacing: 0){
                                    Text("별점 ")
                                    Image(systemName: "chevron.down")
                                }
                            }
                            else{
                                HStack(spacing: 0){
                                    Text("최신순 ")
                                    Image(systemName: "chevron.down")
                                }
                            }
                        }.font(.Body2Medium)
                            .foregroundColor(viewModel.categories == index ? Color.white : Color.black)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(viewModel.categories == index ? Color("surfBlue") : Color.white)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.black.opacity(0.15), lineWidth: 0.75)
                            )
                    }
                }
                Spacer().frame(height: 16)
                
                ScrollView{
                    ZStack(alignment: .top){
                        Color.white
                        VStack(spacing: 0){
                            VStack{
                                HStack{
                                    
                                    Text(DateFormatterManager.shared.date(from: viewModel.selectedDate))
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
                                            Text(" 5점, ")
                                                .font(.Body2Bold)
                                            Text("최고예요")
                                                .font(.Body2Medium)
                                        }
                                        .padding(5)
                                        .background(.white.opacity(0.6))
                                        .cornerRadius(12)
                                        
                                    }
                                    Spacer()
                                    Button{
                                        viewModel.ismemo.toggle()
                                    } label: {
                                        
                                        Text("메모 확인하기 ")
                                            .font(.CaptionMedium)
                                        Image(systemName: "chevron.right")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 12)
                                    }
                                    .foregroundColor(Color("surfBlue").opacity(0.7))
                                    .sheet(isPresented: $viewModel.ismemo){
                                        ModalView( viewModel: viewModel)
                                    }
                                }
                            }
                            .padding(.top)
                            .padding(.bottom)
                            .padding(.horizontal)
                            .background(Color("backgroundSkyblue"))
                            
                            
                            ZStack{
                                Rectangle()
                                    .foregroundColor(Color("brightGray"))
                                HStack(spacing: 50){
                                    Text("시간")
                                    Text("바람")
                                    Text("파도")
                                    Text("수온")
                                    Text("날씨")
                                }
                                .font(.CaptionMedium)
                                .foregroundColor(Color("surfBlue"))
                            }
                            .frame(height: 20)
                            
                            
                            ZStack(alignment: .top){
                                Color.white
                                VStack(spacing: 0){
                                    ForEach(0..<viewModel.chartCounter, id: \.self) { index in
                                        VStack(spacing: 0 ){
                                            ZStack{
                                                Color.clear
                                                    .frame(height: 58)
                                                HStack(spacing: 20){
                                                    Text("\(index + viewModel.startHour)시")
                                                        .font(.CaptionMedium)
                                                        .foregroundColor(.black)
                                                        .opacity(0.7)
                                                    
                                                    HStack(spacing: 5){
                                                        Image(systemName: "paperplane")
                                                            .foregroundColor(Color("iconSkyblue"))
                                                        Text("3.3m/s")
                                                            .font(.Body2Medium)
                                                    }
                                                    HStack(spacing: 5){
                                                        Image(systemName: "paperplane.fill")
                                                            .foregroundColor(Color("surfBlue"))
                                                        VStack(spacing: 0){
                                                            Text("0.2m")
                                                                .font(.Body2Medium)
                                                            Text("3.3m/s")
                                                                .font(.CaptionMedium)
                                                        }
                                                    }
                                                    VStack(spacing: 0){
                                                        Text("28°C")
                                                            .font(.Body2Medium)
                                                        Image(systemName: "water.waves")
                                                            .foregroundColor(Color("iconPurple"))
                                                    }
                                                    HStack(spacing: 5){
                                                        Image(systemName: "cloud")
                                                            .foregroundColor(.gray)
                                                        Text("28°C")
                                                            .font(.Body2Medium)
                                                    }
                                                }
                                            }
                                            
                                            Divider()
                                                .background(Color("surfBlue"))
                                        }
                                    }
                                    
                                }
                            }
                            .frame(height: 58*CGFloat(viewModel.chartCounter))
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
                    
                }
                
            }
        }
    }
}

struct ModalView: View {
    @Query private var surfingRecordOneData: [SurfingRecordOne]
    @ObservedObject var viewModel : RecordChartViewModel
    
    var body: some View {
        ScrollView{
            ForEach(surfingRecordOneData, id: \.id) { item in
                if viewModel.date(from: item.surfingStartTime) == viewModel.date(from: viewModel.selectedDate) {
                    VStack{
                        HStack{
                            Text(date(from: item.surfingStartTime))
                                .font(.Heading3Bold)
                                .foregroundColor(Color("surfBlue"))
                            Spacer()
                            Button{
                            }label: {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 28)
                                    .foregroundColor(.gray)
                            }
                            
                        }
                        HStack(spacing: 0) {
                            HStack(spacing: 0){
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 13)
                                    .foregroundColor(Color("surfBlue"))
                                Text(" 5점, ")
                                    .font(.Body2Bold)
                                Text("최고예요")
                                    .font(.Body2Medium)
                            }
                            .padding(5)
                            .background(Color("backgroundSkyblue"))
                            .cornerRadius(12)
                            Spacer()
                        }
                        HStack(spacing: 0){
                            Text(item.memo)
                            Spacer()
                        }
                        
                    }.padding(.horizontal)
                        .overlay(Color.yellow.opacity(0.3))
                    
                    //                                    Text("Start Time: \(item.surfingStartTime)")
                    //                                    Text("End Time: \(item.surfingEndTime)")
                    //                                    Text("Evaluation: \(item.evaluationValue)")
                    //                                    Text("Memo: \(item.memo)")
                    //                                         Text("\n")
                }
            }
        }
    }
    func date(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateFormat = "MM월 dd일 (E)"
        return formatter.string(from: date)
    }
}

#Preview {
    RecordChartView()
}
