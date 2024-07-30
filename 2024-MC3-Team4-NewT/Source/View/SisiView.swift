////
////  SisiView.swift
////  2024-MC3-Team4-NewT
////
////  Created by ram on 7/21/24.
////
//
//import SwiftUI
//
//struct SisiView: View {
//    @State var selectedDate = Date() //날짜
//    @State var startTime = Date() //시작시간
//    @State var stopTime = Date() //종료시간
//    @State private var selectedScore: Int = 3 //별점 점수
//
//    var body: some View {
//        ZStack{
//            Color(.systemGroupedBackground)
//                .ignoresSafeArea()
//            VStack{
//                ZStack{
//                    Color.white
//                    VStack(spacing: 0){
//                        VStack(spacing: 11){
//                            HStack {
//                                Text("서핑 한 날짜")
//                                    .font(.pretendardSemiBold18)
//                                    .foregroundColor(Color("surfBlue"))
//                                Spacer()
//                                DatePicker("", selection: $selectedDate, displayedComponents: [.date])
//                                    .labelsHidden()
//                                    .colorScheme(.dark)
//                                    .background(
//                                        RoundedRectangle(cornerRadius: 8)
//                                            .fill(Color("surfBlue"))
//                                    )
//                            }.padding(.horizontal)
//                            
//                            Divider()
//                                .padding(.leading)
//                            HStack {
//                                Text("시작 시간대")
//                                    .font(.pretendardSemiBold18)
//                                    .foregroundColor(Color("surfBlue"))
//                                Spacer()
//                                DatePicker("", selection: $startTime, displayedComponents: [.hourAndMinute])
//                                    .labelsHidden()
//                                    .colorScheme(.dark)
//                                    .background(
//                                        RoundedRectangle(cornerRadius: 8)
//                                            .fill(Color("surfBlue"))
//                                    )
//                                    .onChange(of: startTime){ newValue in
//                                        if(startTime>stopTime) {
//                                            startTime=stopTime
//                                        }
//                                    }
//                            }.padding(.horizontal)
//                            
//                            Divider()
//                                .padding(.leading)
//                            HStack {
//                                Text("종료 시간대")
//                                    .font(.pretendardSemiBold18)
//                                    .foregroundColor(Color("surfBlue"))
//                                Spacer()
//                                DatePicker("", selection: $stopTime, displayedComponents: [.hourAndMinute])
//                                    .labelsHidden()
//                                    .colorScheme(.dark)
//                                    .background(
//                                        RoundedRectangle(cornerRadius: 8)
//                                            .fill(Color("surfBlue"))
//                                    )
//                                    .onChange(of: stopTime){ newValue in
//                                        if(startTime>stopTime) {
//                                            stopTime=startTime
//                                        }
//                                    }
//                            }.padding(.horizontal)
//                            
//                            Divider()
//                                .padding(.leading)
//                            Text(date(from: selectedDate))
//                                .font(.pretendardBold18)
//                                .foregroundStyle(Color("surfBlue"))
//                                .padding(.bottom, 11)
//                        }
//                        .padding(.top)
//                        
//                        ZStack{
//                            Rectangle()
//                                .frame(height: 20)
//                                .foregroundColor(Color("brightGray"))
//                            HStack(spacing: 55){
//                                Text("시간")
//                                Text("바람")
//                                Text("파도")
//                                Text("수온")
//                                Text("날씨")
//                            }
//                            .font(.pretendardMedium12)
//                            .foregroundColor(Color("surfBlue"))
//                        }
//                        ZStack(alignment: .top){
//                            Color.white
//                                .frame(height: 174)
//                            VStack(spacing: 0){
//                                if(chartCounter>3){    //여백이 없어지긴 했으나 밑의 오늘의파도평가 스텍이 조금 내려가는 현상 고쳐야함!!
//                                    ScrollView{
//                                        VStack(spacing: 0 ){
//                                            ForEach(0..<chartCounter, id: \.self) { index in
//                                                ZStack{
//                                                    Color.white.opacity(0.8)
//                                                        .frame(height: 58)
//                                                    HStack(spacing: 20){
//                                                        VStack(spacing: 0){
//                                                            Text("7/26")
//                                                                .font(.pretendardSemiBold14)
//                                                            Text("\(index + startHour)시")
//                                                                .font(.pretendardMedium12)
//                                                                .foregroundColor(Color("surfBlue"))
//                                                        }
//                                                        HStack(spacing: 0){
//                                                            Image(systemName: "paperplane")
//                                                                .foregroundColor(Color("iconGreen"))
//                                                            Text("3.3m/s")
//                                                                .font(.pretendardMedium14)
//                                                        }
//                                                        HStack(spacing: 0){
//                                                            Image(systemName: "paperplane.fill")
//                                                                .foregroundColor(Color("iconBlue"))
//                                                            VStack(spacing: 0){
//                                                                Text("0.2m")
//                                                                    .font(.pretendardMedium14)
//                                                                Text("3.3m/s")
//                                                                    .font(.pretendardMedium12)
//                                                            }
//                                                        }
//                                                        VStack(spacing: 0){
//                                                            Text("28°C")
//                                                                .font(.pretendardMedium14)
//                                                            Image(systemName: "water.waves")
//                                                                .foregroundColor(Color("iconWaterOrange"))
//                                                        }
//                                                        HStack(spacing: 0){
//                                                            Image(systemName: "star.fill")
//                                                                .foregroundColor(Color("iconStarOrange"))
//                                                            Text("5")
//                                                                .font(.pretendardMedium14)
//                                                        }
//                                                    }
//                                                }
//                                            }
//                                        }
//
//                                    }
//                                }
//                                
//                                else {
//                                    ForEach(0..<chartCounter, id: \.self) { index in
//                                        ZStack{
//                                            Color.white.opacity(0.8)
//                                                .frame(height: 58)
//                                            HStack(spacing: 20){
//                                                VStack(spacing: 0){
//                                                    Text("7/26")
//                                                        .font(.pretendardSemiBold14)
//                                                    Text("\(index + startHour)시")
//                                                        .font(.pretendardMedium12)
//                                                        .foregroundColor(Color("surfBlue"))
//                                                }
//                                                HStack(spacing: 0){
//                                                    Image(systemName: "paperplane")
//                                                        .foregroundColor(Color("iconGreen"))
//                                                    Text("3.3m/s")
//                                                        .font(.pretendardMedium14)
//                                                }
//                                                HStack(spacing: 0){
//                                                    Image(systemName: "paperplane.fill")
//                                                        .foregroundColor(Color("iconBlue"))
//                                                    VStack(spacing: 0){
//                                                        Text("0.2m")
//                                                            .font(.pretendardMedium14)
//                                                        Text("3.3m/s")
//                                                            .font(.pretendardMedium12)
//                                                    }
//                                                }
//                                                VStack(spacing: 0){
//                                                    Text("28°C")
//                                                        .font(.pretendardMedium14)
//                                                    Image(systemName: "water.waves")
//                                                        .foregroundColor(Color("iconWaterOrange"))
//                                                }
//                                                HStack(spacing: 0){
//                                                    Image(systemName: "star.fill")
//                                                        .foregroundColor(Color("iconStarOrange"))
//                                                    Text("5")
//                                                        .font(.pretendardMedium14)
//                                                }
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                            .frame(width:370,height: 130)
//                        }
//                    }
//                    
//                    
//                    
//                }
//                .cornerRadius(24)
//                .padding(.horizontal)
//                
//                
//                ZStack{
//                    Color.white
//                    VStack(spacing: 11){
//                        HStack(spacing: 0){
//                            Text("오늘의 파도 평가")
//                                .font(.pretendardBold18)
//                                .foregroundColor(Color("surfBlue"))
//                            Spacer()
//                        }
//                        HStack(spacing: 20){
//                            ForEach(1..<6) { index in
//                                Button {
//                                    selectedScore = index
//                                } label: {
//                                    Circle()
//                                        .frame(width: 50, height: 50)
//                                        .foregroundColor(selectedScore == index ? Color("surfBlue") : Color(.systemGroupedBackground)) // 인덱스에 따라 색상 변경
//                                }
//                            }
//                            
//                        }
//                        
//                        HStack(spacing: 0){
//                            Text("파도 코멘트")
//                                .font(.pretendardBold18)
//                                .foregroundColor(Color("surfBlue"))
//                            Spacer()
//                        }
//                        
//                        Button{
//                            
//                        } label: {
//                            ZStack {
//                                Color.white
//                                    .frame(height: 43)
//                                    .cornerRadius(16)
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 16)
//                                            .stroke(Color("surfBlue"), lineWidth: 1.5)
//                                    )
//                                HStack{
//                                    Text("메모 추가")
//                                        .font(.pretendardBold18)
//                                        .foregroundColor(Color("surfBlue"))
//                                    Image(systemName: "plus.circle.fill")
//                                        .foregroundColor(Color("surfBlue"))
//                                }
//                            }
//                        }
//
//                    }
//                    .padding(.vertical)
//                    .padding(.horizontal)
//                }
//                .cornerRadius(24)
//                .padding(.horizontal)
//                    
//                Spacer()
//                    .frame(height: 34)
//                Button{
//                    
//                } label: {
//                    ZStack {
//                        Color("surfBlue")
//                            .frame(height: 51)
//                            .cornerRadius(36)
//                        HStack{
//                            Text("기록 저장")
//                                .font(.pretendardBold18)
//                                .foregroundColor(Color.white)
//                        }
//                    }
//                    .padding(.horizontal)
//                }
//            }
//        }
//        .navigationTitle("파도 기록")
//        
//    }
//    
//    func date(from date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "ko_kr")
//        formatter.dateFormat = "MM월 dd일 (E)"
//        return formatter.string(from: date)
//    }
//    // MARK: - 로직
//
//    
//    
//    
//    var startHour: Int {
//        let calendar = Calendar.current
//        return calendar.component(.hour, from: startTime)
//    }
//    var stopHour: Int {
//        let calendar = Calendar.current
//        return calendar.component(.hour, from: stopTime)
//    }
//    
//    var chartCounter: Int {
//        var counter: Int = 1
//        if stopHour > startHour { //시작시간이 종료시간보다 늦을걸 대비
//            counter = (stopHour - startHour)+1
//        }
//        return counter
//        //+1 하는 이유는 11:20~ 14:30일 경우  11,12,13,14시 총 4개를 보여줘야하기 때문
//    }
//    
//}
//
//#Preview {
//    SisiView()
//}
