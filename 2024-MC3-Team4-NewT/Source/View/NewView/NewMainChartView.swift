//
//  NewMainChartView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/27/24.
//
import SwiftUI

struct WeatherData: Identifiable {
    let id = UUID()
    let time: String
    let windSpeedValue: String
    let waveHeightValue: String
    let wavePeriodValue: String
    let waterTempValue: String
    let airTempValue: String
    let weatherIcon: String
}

struct NewMainChartView: View {
    // State variables for width management
    @State private var timeColumnWidth: CGFloat = 30
    @State private var windColumnWidth: CGFloat = 80
    @State private var waveColumnWidth: CGFloat = 80
    @State private var waterTempColumnWidth: CGFloat = 80
    @State private var weatherColumnWidth: CGFloat = 40

    let data: [WeatherData] = [
        WeatherData(time: "00시", windSpeedValue: "3.3", waveHeightValue: "0.2", wavePeriodValue: "3.3", waterTempValue: "28", airTempValue: "28", weatherIcon: "cloud.rain"),
        WeatherData(time: "01시", windSpeedValue: "4.5", waveHeightValue: "0.3", wavePeriodValue: "4.0", waterTempValue: "27", airTempValue: "27", weatherIcon: "cloud.sun"),
        WeatherData(time: "02시", windSpeedValue: "5.0", waveHeightValue: "0.4", wavePeriodValue: "4.2", waterTempValue: "26", airTempValue: "26", weatherIcon: "cloud.bolt")
    ]
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("7월 25일 목요일")
                    .font(.headline)
                    .padding(.top)
                
                Grid(alignment: .center, horizontalSpacing: 1, verticalSpacing: 10) {
                    GridRow {
                        Text("시간")
                            .frame(width: timeColumnWidth, alignment: .leading)
                            .background(GeometryReader { geo -> Color in
                                DispatchQueue.main.async {
                                    self.timeColumnWidth = geo.size.width
                                }
                                return Color.clear
                            })
                        Text("바람")
                            .frame(width: windColumnWidth, alignment: .leading)
                            .background(GeometryReader { geo -> Color in
                                DispatchQueue.main.async {
                                    self.windColumnWidth = geo.size.width
                                }
                                return Color.clear
                            })
                        Text("파도")
                            .frame(width: waveColumnWidth, alignment: .leading)
                            .background(GeometryReader { geo -> Color in
                                DispatchQueue.main.async {
                                    self.waveColumnWidth = geo.size.width
                                }
                                return Color.clear
                            })
                        Text("수온")
                            .frame(width: waterTempColumnWidth, alignment: .leading)
                            .background(GeometryReader { geo -> Color in
                                DispatchQueue.main.async {
                                    self.waterTempColumnWidth = geo.size.width
                                }
                                return Color.clear
                            })
                        Text("날씨")
                            .frame(width: weatherColumnWidth, alignment: .leading)
                            .background(GeometryReader { geo -> Color in
                                DispatchQueue.main.async {
                                    self.weatherColumnWidth = geo.size.width
                                }
                                return Color.clear
                            })
                    }
                    .font(.subheadline)
                    .bold()
                    .background(Color(UIColor.systemGray6))
                    
                    ForEach(data) { item in
                        GridRow {
                            Text(item.time)
                                .frame(width: timeColumnWidth, alignment: .leading)
                            
                            HStack {
                                Image("waveDirectionIcon2")
                                    .frame(width: 14, height: 18)
                                    .rotationEffect(Angle(degrees: Double(10.0)))
                                HStack(alignment: .top, spacing: 0) {
                                    Text(item.windSpeedValue)
                                        .font(.system(size: 15))
                                    Text("m/s")
                                        .font(.footnote)
                                }
                            }
                            .frame(width: windColumnWidth, alignment: .leading)
                            
                            HStack {
                                Image("swellDirectionIcon")
                                    .rotationEffect(Angle(degrees: Double(330.0)))
                                VStack(alignment: .leading, spacing: 2) {
                                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                                        Text(item.waveHeightValue)
                                            .font(.system(size: 15))
                                        Text("m")
                                            .font(.footnote)
                                    }
                                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                                        Text(item.wavePeriodValue)
                                            .font(.system(size: 15))
                                        Text("s")
                                            .font(.footnote)
                                    }
                                }
                            }
                            .frame(width: waveColumnWidth, alignment: .leading)
                            
                            VStack(alignment: .center) {
                                HStack(alignment: .firstTextBaseline, spacing: 0) {
                                    Text(item.waterTempValue)
                                        .font(.system(size: 15))
                                    Text("℃")
                                        .font(.footnote)
                                }
                                Image("waterTemperate")
                            }
                            .frame(width: waterTempColumnWidth, alignment: .leading)
                            
                            HStack {
                                Image(systemName: item.weatherIcon)
                                HStack(alignment: .firstTextBaseline, spacing: 0) {
                                    Text(item.airTempValue)
                                        .font(.system(size: 15))
                                    Text("℃")
                                        .font(.footnote)
                                }
                            }
                            .frame(width: weatherColumnWidth, alignment: .leading)
                        }
                    }
                }
                
                Spacer()
                
            }
            .padding(.horizontal)
            .frame(width: geometry.size.width)
            .background(Color.white.opacity(0.8))
            .cornerRadius(24)
        }
    }
}

#Preview {
    NewMainChartView()
}
