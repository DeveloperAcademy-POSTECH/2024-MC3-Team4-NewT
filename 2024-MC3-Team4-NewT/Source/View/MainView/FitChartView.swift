import SwiftUI
import SwiftData

struct FitChartView: View {
    @Query var statistics: [Statistics]
    var body: some View {
        VStack(spacing: 0){
//            VStack {
//                Button{
//                    print("지역 선택 버튼 눌림")
//                }label: {
//                    HStack(alignment: .center, spacing: 4){
//                        Text("포항 신항만 해변A")
//                            .font(.SubheadingSemiBold)
//                            .foregroundColor(.white)
//                        Image(systemName: "chevron.down")
//                            .foregroundColor(.white)
//                    }
//                    .opacity(0.7)
//                    Spacer()
//                }
//                .padding(.vertical, 6)
//                
//            }
            
            //MARK: 메인뷰 상단 메뉴
            TabView{
                //통계 데이터가 없을 때 나타낼 화면 필요
                if let firstStatistic = statistics.first {
                    StatisticsView()
                } else {
                    Text("통계 데이터가 없습니다.")
                }
                RecentChartsView()
                PinChartsView()
            }.padding(.top, 12)
            .frame(maxHeight: 256)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            // .never 로 하면 배경 안보이고 .always 로 하면 인디케이터 배경 보입니다.
        }
    }
}


