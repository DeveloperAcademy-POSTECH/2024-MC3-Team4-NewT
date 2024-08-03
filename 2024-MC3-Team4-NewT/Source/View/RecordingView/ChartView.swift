//
//  ChartView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/3/24.
//
import SwiftUI
import SwiftData

struct ChartView: View {
    @Binding var startTime: Date
    @Binding var stopTime: Date
    @Binding var isChartScroll: Bool
    @Query var chartRows: [ChartRow]
    
    var body: some View {
        ZStack(alignment: .top){
            Color.white
            VStack(spacing: 0){
                ScrollView{
                    VStack(spacing: 0){
                        let filteredRows = filterChartRows(chartRows, startTime: startTime, stopTime: stopTime)
                        
                        ForEach(filteredRows.indices, id: \.self) { index in
                            let row = filteredRows[index]
                            ZStack{
                                Color.white.opacity(0.8)
                                    .frame(height: 58)
                                HStack(spacing: 20){
                                    VStack(spacing: 0){
                                        Text(DateFormatterManager.shared.timeToHourFormatter(row.time))
                                            .font(.CaptionMedium)
                                            .foregroundColor(.black)
                                            .opacity(0.7)
                                    }
                                    HStack(spacing: 5){
                                        Image(systemName: "paperplane")
                                            .foregroundColor(Color("iconSkyblue"))
                                        Text("\(row.surfingValues.windSpeed, specifier: "%.1f")m/s")
                                            .font(.CaptionMedium)
                                    }
                                    HStack(spacing: 5){
                                        Image(systemName: "paperplane.fill")
                                            .foregroundColor(Color("surfBlue"))
                                        VStack(spacing: 0){
                                            Text("\(row.surfingValues.waveHeight, specifier: "%.1f")m")
                                                .font(.CaptionMedium)
                                            Text("\(row.surfingValues.wavePeriod, specifier: "%.1f")s")
                                                .font(.CaptionMedium)
                                        }
                                    }
                                    VStack(spacing: 0){
                                        Text("\(row.surfingValues.waterTemperature, specifier: "%.1f")°C")
                                            .font(.Body2Medium)
                                        Image(systemName: "water.waves")
                                            .foregroundColor(Color("iconPurple"))
                                    }
                                    HStack(spacing: 5){
                                        Image(systemName: weatherIcon(for: row.surfingValues.weather))
                                            .foregroundColor(.gray)
                                        Text("\(row.surfingValues.airTemperature, specifier: "%.1f")°C")
                                            .font(.Body2Medium)
                                    }
                                }
                                if (filteredRows.count > 3){
                                    if (index < filteredRows.count - 1){
                                        Divider()
                                            .background(Color("surfBlue"))
                                            .padding(.top, 58)
                                    }
                                }
                                else {
                                    if (index == 0 || index == 1){
                                        Divider()
                                            .background(Color("surfBlue"))
                                            .padding(.top, 58)
                                    }
                                }
                            }
                        }
                    }
                }
                .scrollDisabled(isChartScroll)
            }
        }
        .frame(height: 174)
    }
    
    func timeToHourFormatter(_ timeString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: timeString) {
            let hourFormatter = DateFormatter()
            hourFormatter.dateFormat = "H시"
            return hourFormatter.string(from: date)
        }
        return timeString // If parsing fails, return the original string
    }
    
    func filterChartRows(_ rows: [ChartRow], startTime: Date, stopTime: Date) -> [ChartRow] {
        let calendar = Calendar.current
        
        // Find the nearest 3-hour interval to the start time
        let startHour = calendar.component(.hour, from: startTime)
        let nearestStartHour = (startHour / 3) * 3
        let adjustedStartTime = calendar.date(bySettingHour: nearestStartHour, minute: 0, second: 0, of: startTime) ?? startTime
        
        // Filter the rows between adjustedStartTime and stopTime
        return rows.filter { row in
            if let rowDate = dateFromString(row.time) {
                return rowDate >= adjustedStartTime && rowDate <= stopTime
            }
            return false
        }
    }
    
    func dateFromString(_ timeString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: timeString)
    }
    
    func weatherIcon(for weather: String) -> String {
        switch weather.lowercased() {
        case "sunny":
            return "sun.max"
        case "cloudy":
            return "cloud"
        case "rainy":
            return "cloud.rain"
        default:
            return "questionmark"
        }
    }
}
