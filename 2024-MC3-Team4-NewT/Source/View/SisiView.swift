//
//  SisiView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/21/24.
//

import SwiftUI

struct SisiView: View {
    @State var selectedDate = Date()
    @State var startTime = Date()
    @State var stopTime = Date()
    @State var selectedScore: Int = 0
    @State var isScore = 0.0
    @State var isMemo: Bool = true
    @State var memo: String = ""
    let placeHolding: String = "파도에 대한 간단한 메모를 남겨보세요."
    let placeHolding1: String = "(최대 100자)"
    
    let memoLimit: Int = 100
    @State var heightSize: CGFloat = 245.0

    var body: some View {
        ZStack(alignment: .top){
            Color("backgroundGray")
                .ignoresSafeArea()
            VStack(spacing: 0){
                ScrollView{
                    VStack{
                        ZStack(alignment: .top){
                            Color.white
                            VStack(spacing: 0){
                                VStack(spacing: 5){
                                    Spacer().frame(height: 13)
                                    HStack {
                                        Text("서핑 한 날짜")
                                            .font(.pretendardSemiBold18)
                                            .foregroundColor(Color("surfBlue"))
                                        Spacer()
                                        DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                                            .labelsHidden()
                                            .colorScheme(.dark)
                                            .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color("surfBlue"))
                                            )
                                    }.padding(.horizontal)
                                    
                                    Divider()
                                        .padding(.leading)
                                    HStack {
                                        Text("시작 시간대")
                                            .font(.pretendardSemiBold18)
                                            .foregroundColor(Color("surfBlue"))
                                        Spacer()
                                        DatePicker("", selection: $startTime, displayedComponents: [.hourAndMinute])
                                            .labelsHidden()
                                            .colorScheme(.dark)
                                            .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color("surfBlue"))
                                            )
                                            .onChange(of: startTime){ newValue in
                                                if(startTime>stopTime) {
                                                    startTime=stopTime
                                                }
                                            }
                                    }.padding(.horizontal)
                                    
                                    Divider()
                                        .padding(.leading)
                                    HStack {
                                        Text("종료 시간대")
                                            .font(.pretendardSemiBold18)
                                            .foregroundColor(Color("surfBlue"))
                                        Spacer()
                                        DatePicker("", selection: $stopTime, displayedComponents: [.hourAndMinute])
                                            .labelsHidden()
                                            .colorScheme(.dark)
                                            .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color("surfBlue"))
                                            )
                                            .onChange(of: stopTime){ newValue in
                                                if(startTime>stopTime) {
                                                    stopTime=startTime
                                                }
                                            }
                                    }.padding(.horizontal)
                                    
                                    Divider()
                                        .padding(.leading)
                                    Text(date(from: selectedDate))
                                        .font(.pretendardBold18)
                                        .foregroundStyle(Color("surfBlue"))
                                        .padding(.vertical, 8)
                                }
                                
                                ZStack{
                                    Rectangle()
                                        .frame(height: 20)
                                        .foregroundColor(Color("brightGray"))
                                    HStack(spacing: 50){
                                        Text("시간")
                                        Text("바람")
                                        Text("파도")
                                        Text("수온")
                                        Text("날씨")
                                    }
                                    .font(.pretendardMedium12)
                                    .foregroundColor(Color("surfBlue"))
                                }
                                ZStack(alignment: .top){
                                    Color.white
                                    VStack(spacing: 0){
                                        if(chartCounter>3){
                                            ScrollView{
                                                VStack(spacing: 0 ){
                                                    ForEach(0..<chartCounter, id: \.self) { index in
                                                        ZStack{
                                                            Color.white.opacity(0.8)
                                                                .frame(height: 58)
                                                            HStack(spacing: 20){
                                                                VStack(spacing: 0){
                                                                    Text("\(index + startHour)시")
                                                                        .font(.pretendardMedium12)
                                                                        .foregroundColor(.black)
                                                                        .opacity(0.7)
                                                                }
                                                                HStack(spacing: 5){
                                                                    Image(systemName: "paperplane")
                                                                        .foregroundColor(Color("iconSkyblue"))
                                                                    Text("3.3m/s")
                                                                        .font(.pretendardMedium14)
                                                                }
                                                                HStack(spacing: 5){
                                                                    Image(systemName: "paperplane.fill")
                                                                        .foregroundColor(Color("surfBlue"))
                                                                    VStack(spacing: 0){
                                                                        Text("0.2m")
                                                                            .font(.pretendardMedium14)
                                                                        Text("3.3m/s")
                                                                            .font(.pretendardMedium12)
                                                                    }
                                                                }
                                                                VStack(spacing: 0){
                                                                    Text("28°C")
                                                                        .font(.pretendardMedium14)
                                                                    Image(systemName: "water.waves")
                                                                        .foregroundColor(Color("iconPurple"))
                                                                }
                                                                HStack(spacing: 5){
                                                                    Image(systemName: "cloud")
                                                                        .foregroundColor(.gray)
                                                                    Text("28°C")
                                                                        .font(.pretendardMedium14)
                                                                }
                                                            }
                                                            if (index < chartCounter - 1){
                                                                Divider()
                                                                    .background(Color("surfBlue"))
                                                                    .padding(.top, 58)
                                                            }
                                                        }
                                                    }
                                                }

                                            }
                                        }
                                        else {
                                            ForEach(0..<chartCounter, id: \.self) { index in
                                                VStack(spacing: 0 ){
                                                    ZStack{
                                                        Color.clear
                                                            .frame(height: 58)
                                                        HStack(spacing: 20){
                                                            Text("\(index + startHour)시")
                                                                .font(.pretendardMedium12)
                                                                .foregroundColor(.black)
                                                                .opacity(0.7)
                                                            
                                                            HStack(spacing: 5){
                                                                Image(systemName: "paperplane")
                                                                    .foregroundColor(Color("iconSkyblue"))
                                                                Text("3.3m/s")
                                                                    .font(.pretendardMedium14)
                                                            }
                                                            HStack(spacing: 5){
                                                                Image(systemName: "paperplane.fill")
                                                                    .foregroundColor(Color("surfBlue"))
                                                                VStack(spacing: 0){
                                                                    Text("0.2m")
                                                                        .font(.pretendardMedium14)
                                                                    Text("3.3m/s")
                                                                        .font(.pretendardMedium12)
                                                                }
                                                            }
                                                            VStack(spacing: 0){
                                                                Text("28°C")
                                                                    .font(.pretendardMedium14)
                                                                Image(systemName: "water.waves")
                                                                    .foregroundColor(Color("iconPurple"))
                                                            }
                                                            HStack(spacing: 5){
                                                                Image(systemName: "cloud")
                                                                    .foregroundColor(.gray)
                                                                Text("28°C")
                                                                    .font(.pretendardMedium14)
                                                            }
                                                        }
                                                    }
                                                    if (index == 0 || index == 1){
                                                        Divider()
                                                            .background(Color("surfBlue"))
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                .frame(height: 174)
                            }
                            
                        }
                        .cornerRadius(24)
                        .padding(.horizontal)
                        
                        ZStack(alignment: .top){
                            Color.white
                            VStack(spacing:0){
                                Spacer()
                                    .frame(height: 16)
                                HStack(spacing: 0){
                                    Text("오늘의 파도 평가")
                                        .font(.pretendardBold18)
                                        .foregroundColor(Color("surfBlue"))
                                    Spacer()
                                }.padding(.bottom, 20)
                                
                                ZStack{
                                    ProgressView(value: isScore, total: 4.0)
                                        .tint(Color("surfBlue"))
                                    HStack(spacing: 50){
                                        ForEach(0..<5) { index in
                                                Button {
                                                    selectedScore = index
                                                    isScore = Double(index)
                                                } label: {
                                                    Circle()
                                                        .frame(width: 20, height: 20)
                                                        .foregroundColor(selectedScore >= index ? Color("surfBlue") : Color("backgroundGray"))
                                                }
                                        }
                                        
                                    }
                                }
                                .frame(width: 296)
                                .padding(.bottom, 11)
                                
                                HStack(spacing: 0){
                                    VStack{
                                        Text("1점")
                                            .font(.pretendardBold14)
                                            .foregroundColor(Color("surfBlue"))
                                        Text("별로예요")
                                            .font(.pretendardMedium12)
                                            .foregroundColor(Color("surfBlue"))
                                    }
                                    Spacer()
                                    VStack{
                                        Text("2점")
                                            .font(.pretendardBold14)
                                            .foregroundColor(Color("surfBlue"))
                                        Text("아쉬워요")
                                            .font(.pretendardMedium12)
                                            .foregroundColor(Color("surfBlue"))
                                    }
                                    Spacer()

                                    VStack{
                                        Text("3점")
                                            .font(.pretendardBold14)
                                            .foregroundColor(Color("surfBlue"))
                                        Text("그저그래요")
                                            .font(.pretendardMedium12)
                                            .foregroundColor(Color("surfBlue"))
                                    }
                                    Spacer()

                                    VStack{
                                        Text("4점")
                                            .font(.pretendardBold14)
                                            .foregroundColor(Color("surfBlue"))
                                        Text("괜찮아요")
                                            .font(.pretendardMedium12)
                                            .foregroundColor(Color("surfBlue"))
                                    }
                                    Spacer()

                                    VStack{
                                        Text("5점")
                                            .font(.pretendardBold14)
                                            .foregroundColor(Color("surfBlue"))
                                        Text("최고예요")
                                            .font(.pretendardMedium12)
                                            .foregroundColor(Color("surfBlue"))
                                    }
                                }
                                .padding(.bottom, 16)
                                HStack(spacing: 0){
                                    Text("파도 코멘트")
                                        .font(.pretendardBold18)
                                        .foregroundColor(Color("surfBlue"))
                                    Spacer()
                                }.padding(.bottom, 8)
                                
                                if isMemo{
                                    Button{
                                        isMemo.toggle()
                                        heightSize = 322.0
                                    } label: {
                                        ZStack {
                                            Color.white
                                                .frame(height: 43)
                                                .cornerRadius(16)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .stroke(Color("surfBlue"), lineWidth: 1.5)
                                                )
                                            HStack{
                                                Text("메모 추가")
                                                    .font(.pretendardBold18)
                                                    .foregroundColor(Color("surfBlue"))
                                                Image(systemName: "plus.circle.fill")
                                                    .foregroundColor(Color("surfBlue"))
                                            }
                                        }
                                    }
                                }
                                else {
                                    ZStack(alignment: .top){
                                        TextEditor(text: $memo)
                                            .frame(height: 120)
                                            .font(.pretendardMedium16)
                                            .foregroundColor(Color.black)
                                            .padding(5)
                                            .lineSpacing(5)
                                            .scrollContentBackground(.hidden)
                                            .background(Color(.systemGroupedBackground))
                                            .cornerRadius(12)
                                            .onChange(of: memo){ newValue in
                                                if newValue.count > memoLimit {
                                                    memo = String(newValue.prefix(memoLimit))
                                                }
                                            }
                                        if(memo.isEmpty)
                                        {
                                            VStack(spacing: 0){
                                                HStack(spacing: 0){
                                                    Text(placeHolding)
                                                        .font(.pretendardMedium16)
//                                                        .lineSpacing(5)
                                                        .foregroundColor(Color.gray)
                                                        .padding(.top, 13)
                                                    
                                                    Spacer()
                                                }
                                                HStack(spacing: 0){
                                                    Text(placeHolding1)
                                                        .font(.pretendardMedium14)
                                                        .foregroundColor(Color.gray)
                                                    Spacer()
                                                }
                                            }
                                            .padding(.horizontal, 13)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: heightSize)
                        .cornerRadius(24)
                        .padding(.horizontal)
                    }
                }.scrollDisabled(isMemo)
                    .padding(.bottom)
                
                Button{
                    isMemo.toggle()
                    if isMemo {
                        
                        heightSize = 245.0
                    }
                    else {
                        heightSize = 322.0
                    }
                    //저장 기능 넣어야함
                    
                } label: {
                    ZStack {
                        Color("surfBlue")
                            .frame(height: 51)
                            .cornerRadius(36)
                        HStack{
                            Text("기록 저장")
                                .font(.pretendardBold18)
                                .foregroundColor(Color.white)
                        }
                    }
                    .padding(.horizontal)
                    
                }
                Spacer()
                
            }
        }
        .navigationTitle("파도 기록")
        
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
    SisiView()
}
