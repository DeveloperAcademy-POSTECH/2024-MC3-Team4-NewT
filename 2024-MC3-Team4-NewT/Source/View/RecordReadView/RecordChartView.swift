import Foundation
import SwiftUI

struct RecordChartView: View {
    @State var categories: Int = 0
    
    
    @State var selectedDate = Date()
    @State var startTime = Date()
    @State var stopTime = Date()
    @State var isEllipsisOnOff: Bool = false
    
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
                            categories = index
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
                            .foregroundColor(categories == index ? Color.white : Color.black)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(categories == index ? Color("surfBlue") : Color.white)
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
                                    Text(date(from: selectedDate))
                                        .font(.SubheadingBold)
                                        .foregroundColor(Color("surfBlue"))
                                    Spacer()
                                    Button{
                                        withAnimation{
                                            isEllipsisOnOff.toggle()
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
                                        
                                    } label: {
                                        
                                        Text("메모 확인하기 ")
                                            .font(.CaptionMedium)
                                        Image(systemName: "chevron.right")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 12)
                                    }
                                    .foregroundColor(Color("surfBlue").opacity(0.7))
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
                                    ForEach(0..<chartCounter, id: \.self) { index in
                                        VStack(spacing: 0 ){
                                            ZStack{
                                                Color.clear
                                                    .frame(height: 58)
                                                HStack(spacing: 20){
                                                    Text("\(index + startHour)시")
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
                            .frame(height: 58*CGFloat(chartCounter))
                        }
                        
                        if isEllipsisOnOff {
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
                                .frame(width: isEllipsisOnOff ? 250 : 0, height: isEllipsisOnOff ? 132 : 0)
                                .cornerRadius(12)
                                .shadow(radius: 10)
                                .padding(.top,47)
                                .padding(.trailing, 16)
                            }
                            
                        }
                    }
                    .frame(height: 110+CGFloat((58 * chartCounter)))
                    .cornerRadius(24)
                    .padding(.horizontal)
                    
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
    
    var startHour: Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: startTime)
    }
    var stopHour: Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: stopTime)
    }
    
    var chartCounter: Int {
        var counter: Int = 1
        if stopHour > startHour {
            counter = (stopHour - startHour)+1
        }
        return counter
    }
}

#Preview {
    RecordChartView()
}
