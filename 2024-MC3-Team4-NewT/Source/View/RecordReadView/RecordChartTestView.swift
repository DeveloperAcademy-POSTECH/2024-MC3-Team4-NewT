import Foundation
import SwiftUI
import SwiftData
struct RecordChartTestView: View {
    @Query private var surfingRecordOneData: [SurfingRecordOne]
    @ObservedObject var viewModel: RecordChartViewModel
    @Query(sort: \ChartRow.time) var chartRow: [ChartRow]
    var recordOne: SurfingRecordOne
    @EnvironmentObject var myObject: MyObservableObject
    @State private var selectedItem: ChartRow?
    @State var kkk = false
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
                                            selectedItem = row
                                            
                                            viewModel.isChartPinButton[row.id, default: false].toggle()
                                            viewModel.rowTime = row.time
                                            viewModel.pinRecord = row.surfingRecordStartTime ?? Date()
                                            viewModel.confirmPin(row.time, row.surfingRecordStartTime ?? Date())
                                            viewModel.isRecord = true
                                            if viewModel.isRecord == false {
                                                kkk = true
                                            }
                                        
                                        } label: {
                                            Image(systemName: "checkmark.circle.fill")
                                                .frame(width: 20)
                                                .foregroundColor(viewModel.isChartPinButton[row.id] == true ? Color("surfBlue") : Color(.systemGroupedBackground))
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
                        
                    }
                }
            }
            
        }
        .alert(isPresented: $kkk) {
            Alert(
                title: Text("차트를 고정하시겠습니까?"),
                primaryButton: .default(Text("네")) {
                    print("Pin saved.")
                    viewModel.savePinTime(viewModel.rowTime, viewModel.pinRecord)
                    viewModel.isChartPinButton[viewModel.chartRowId] = false
                    viewModel.isPinButton[viewModel.recordId] = false
                },
                secondaryButton: .cancel(Text("취소"))
            )
        }
        
        
    }
    
}
