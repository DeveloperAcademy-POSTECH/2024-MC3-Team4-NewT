import Foundation
import SwiftUI
import SwiftData

struct RecordChartTestView: View {
    @Query private var surfingRecordOneData: [SurfingRecordOne]
    @ObservedObject var viewModel: RecordChartViewModel
    @Query(sort: \ChartRow.time) var chartRow: [ChartRow]
    var recordOne: SurfingRecordOne
    
    var body: some View {
        VStack(spacing: 0) {
            let data = viewModel.filteredRecordChart(charts: chartRow, recordOne: recordOne)
            
            ZStack {
                Rectangle()
                    .foregroundColor(Color("brightGray"))
                
                HStack(spacing: 50) {
                    Text("시간")
                    Text("바람")
                    Text("파도")
                    Text("수온")
                    Text("날씨")
                }
                .font(.CaptionMedium)
                .foregroundColor(Color.black.opacity(0.6))
            }
            .frame(height: 20)
            
            ZStack(alignment: .top) {
                Color.white
                VStack(spacing: 0) {
                    ForEach(data.indices, id: \.self) { index in
                        let row = data[index]
                        VStack(spacing: 0) {
                            ZStack {
                                Color.clear
                                    .frame(height: 58)
                                
                                HStack(spacing: 20) {
                                    if viewModel.isPinButton[recordOne.id] == true {
                                        Button {
                                            
                                            viewModel.isChartPinButotn[row.id, default: false].toggle()
//                                            print ("고정 row: \(row.id)")
                                            if (viewModel.isChartPinButotn[row.id] == true && viewModel.isPinCounter < 3) {
                                                viewModel.isPinCounter += 1
                                            }
                                            else if (viewModel.isChartPinButotn[row.id] == false) {
                                                viewModel.isPinCounter -= 1
                                                viewModel.isChartPinButotn[row.id] = false
                                            }
                                            else {
                                                viewModel.isChartPinButotn[row.id] = false
                                            }
                                        } label: {
                                            Image(systemName: "checkmark.circle.fill")
                                                .frame(width: 20)
                                                .foregroundColor(viewModel.isChartPinButotn[row.id] == true ? Color("surfBlue") : Color(.systemGroupedBackground))
                                        }
                                    }
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
                                        Text("\(row.surfingValues.airTemperature, specifier: "%.0f")°C")
                                            .font(.Body2Medium)
                                    }
                                }
                                .padding(.horizontal, 10)
                            }
                        }
                        .onAppear{
                            print ("****row: \(row.id)")
                        }
                    }
                }
            }
        }
    }
}
