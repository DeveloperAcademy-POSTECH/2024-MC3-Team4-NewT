import SwiftUI
import SwiftData

struct FitChartView: View {
    
    var body: some View {
        VStack(spacing: 0){
            //MARK: 메인뷰 상단 메뉴
            TabView{
                //통계 데이터가 없을 때 나타낼 화면 필요
                StatisticsView()
                RecentChartsView()
                PinChartsView()
            }
                .frame(maxHeight: 240)
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            // .never 로 하면 배경 안보이고 .always 로 하면 인디케이터 배경 보입니다.
        }
        
    }
}


