import SwiftUI
import SwiftData

struct SisiView: View {
    @Environment(\.modelContext) var modelContext
    @State var selectedDate = Date()
    @State var startTime = Date()
    @State var stopTime = Date()
    @State var selectedScore: Int = 0
    @State var isChartScroll: Bool = true
    @State var isScore = 0.0
    @State var isMemo: Bool = true
    @State var memo: String = ""
    let placeHolding: String = "파도에 대한 간단한 메모를 남겨보세요."
    let placeHolding1: String = "(최대 200자)"
    let memoLimit: Int = 200
    @State var heightSize: CGFloat = 245.0
    var ob = ChartRecordObservable()
    var body: some View {
        
        ZStack(alignment: .top){
            Color(.systemGroupedBackground)
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
                                            .font(.SubheadingSemiBold)
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
                                            .font(.SubheadingSemiBold)
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
                                                updateChartScroll()
                                            }
                                    }.padding(.horizontal)
                                    
                                    Divider()
                                        .padding(.leading)
                                    
                                    HStack {
                                        Text("종료 시간대")
                                            .font(.SubheadingSemiBold)
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
                                                updateChartScroll()
                                            }
                                    }
                                    .padding(.horizontal)
                                }
                                Divider()
                                    .padding(.leading)
                                Text(date(from: selectedDate))
                                    .font(.SubheadingBold)
                                    .foregroundStyle(Color("surfBlue"))
                                    .padding(.vertical, 8)
                                ZStack{
                                    Rectangle()
                                        .frame(height: 20)
                                        .foregroundColor(Color(.systemGroupedBackground))
                                    HStack(spacing: 50){
                                        Text("시간")
                                        Text("바람")
                                        Text("파도")
                                        Text("수온")
                                        Text("날씨")
                                    }
                                    .font(.CaptionMedium)
                                    .foregroundColor(Color(.black).opacity(0.5))
                                }
                                
                                ChartView(
                                    startTime: $startTime, 
                                    stopTime: $stopTime,
                                    isChartScroll: $isChartScroll, observable: ob
                                )
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
                                        .font(.SubheadingBold)
                                        .foregroundColor(Color("surfBlue"))
                                    Spacer()
                                }.padding(.bottom, 20)
                                
                                ZStack{
                                    ProgressView(value: isScore, total: 4.0)
                                        .tint(Color("surfBlue"))
                                        .background(Color("brightGray"))
                                    
                                    HStack(spacing: 50){
                                        ForEach(0..<5) { index in
                                            Button {
                                                selectedScore = index
                                                isScore = Double(index)
                                            } label: {
                                                Circle()
                                                    .frame(width: 20, height: 20)
                                                    .foregroundColor(selectedScore >= index ? Color("surfBlue") : Color(.systemGroupedBackground))
                                            }
                                        }
                                        
                                    }
                                }
                                .frame(width: 296)
                                .padding(.bottom, 11)
                                
                                HStack(spacing: 0){
                                    VStack{
                                        Text("1점")
                                            .font(.Body2Bold)
                                            .foregroundColor(Color("surfBlue"))
                                        Text("별로예요")
                                            .font(.CaptionMedium)
                                            .foregroundColor(Color("surfBlue"))
                                    }
                                    Spacer()
                                    VStack{
                                        Text("2점")
                                            .font(.Body2Bold)
                                            .foregroundColor(Color("surfBlue"))
                                        Text("아쉬워요")
                                            .font(.CaptionMedium)
                                            .foregroundColor(Color("surfBlue"))
                                    }
                                    Spacer()
                                    
                                    VStack{
                                        Text("3점")
                                            .font(.Body2Bold)
                                            .foregroundColor(Color("surfBlue"))
                                        Text("보통이에요")
                                            .font(.CaptionMedium)
                                            .foregroundColor(Color("surfBlue"))
                                    }
                                    Spacer()
                                    
                                    VStack{
                                        Text("4점")
                                            .font(.Body2Bold)
                                            .foregroundColor(Color("surfBlue"))
                                        Text("만족해요")
                                            .font(.CaptionMedium)
                                            .foregroundColor(Color("surfBlue"))
                                    }
                                    Spacer()
                                    
                                    VStack{
                                        Text("5점")
                                            .font(.Body2Bold)
                                            .foregroundColor(Color("surfBlue"))
                                        Text("최고예요")
                                            .font(.CaptionMedium)
                                            .foregroundColor(Color("surfBlue"))
                                    }
                                }
                                .padding(.bottom, 16)
                                HStack(spacing: 0){
                                    Text("파도 코멘트")
                                        .font(.SubheadingBold)
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
                                                    .font(.SubheadingSemiBold)
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
                                            .font(.Body1Medium)
                                            .foregroundColor(Color.black)
                                            .padding(5)
                                            .lineSpacing(5)
                                            .scrollContentBackground(.hidden)
                                            .background(Color("brightGray"))
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
                                                        .font(.Body1Medium)                    .foregroundColor(Color.gray)
                                                        .padding(.top, 13)
                                                    
                                                    Spacer()
                                                }
                                                HStack(spacing: 0){
                                                    Text(placeHolding1)
                                                        .font(.Body2Medium)
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
                    modelContext.insert(SurfingRecordOne(surfingStartTime: startTime, surfingEndTime: stopTime, charts: [], evaluationValue: memoLimit, memo: memo))
                    
                    if isMemo {
                        
                        heightSize = 245.0
                    }
                    else {
                        heightSize = 322.0
                    }
                    
                } label: {
                    ZStack {
                        Color("surfBlue")
                            .frame(height: 51)
                            .cornerRadius(36)
                        HStack{
                            Text("기록 저장")
                                .font(.SubheadingBold)
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
    
    func updateChartScroll() {
        let counter = chartCounter
        if counter > 3 {
            isChartScroll = false
        } else {
            isChartScroll = true
        }
    }
    
    var chartCounter: Int {
        var counter: Int = 1
        if stopHour > startHour {
            counter = (stopHour - startHour) + 1
        }
        return counter
    }
    
    var startHour: Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: startTime)
    }
    
    var stopHour: Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: stopTime)
    }
}

#Preview {
    SisiView()
}
