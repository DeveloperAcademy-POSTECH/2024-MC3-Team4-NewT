import Foundation
import SwiftUI
import SwiftData

struct RecordEachChartView: View {
    @Query private var surfingRecordOneData: [SurfingRecordOne]
    @ObservedObject var viewModel: RecordChartViewModel
    @Query(sort:\ChartRow.time) var chartRow: [ChartRow]
    var recordOne: SurfingRecordOne
    var item: SurfingRecordOne
    var body: some View {
        
        HStack(spacing: 20) {
            Text(DateFormatterManager.shared.timeToHourFormatter(row.time))
                .font(.CaptionMedium)
                .foregroundColor(.black)
                .opacity(0.7)
            
            HStack(spacing: 5) {
                Image(systemName: "paperplane")
                    .foregroundColor(Color("iconSkyblue"))
                Text("\(row.surfingValues.windSpeed, specifier: "%.1f")m/s")
                    .font(.Body2Medium)
            }
            
            HStack(spacing: 5) {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(Color("surfBlue"))
                VStack(spacing: 0) {
                    Text("\(row.surfingValues.waveHeight, specifier: "%.1f")m")
                        .font(.Body2Medium)
                    Text("\(row.surfingValues.wavePeriod, specifier: "%.1f")m/s")
                        .font(.CaptionMedium)
                }
            }
            VStack(spacing: 0) {
                Text("\(row.surfingValues.waterTemperature, specifier: "%.0f")°C")
                    .font(.Body2Medium)
                Image(systemName: "water.waves")
                    .foregroundColor(Color("iconPurple"))
            }
            
            HStack(spacing: 5) {
                Image(systemName: "cloud")
                    .foregroundColor(.gray)
                Text(row.surfingValues.weather)
                    .font(.Body2Medium)
            }
        }
    }
}
    
    

