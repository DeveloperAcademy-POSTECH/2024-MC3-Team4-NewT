//
//  NewRecordCreateChartView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/30/24.
//
import SwiftUI
import SwiftData

struct NewRecordCreateChartView: View {
    @ObservedObject var oldViewModel: RecordCreateViewModel
    @ObservedObject var newViewModel:NewRecordCreateViewModel

    // 더미 데이터 배열 정의
    let dummyData = [
        DummyChartRow(time: "12:00 PM", windSpeed: "5.0m/s", windDirection: 45, waveHeight: "2.0m", wavePeriod: "10.0s", waveDirection: 180, waterTemperature: "22.5°C", airTemperature: "25.0°C", weatherIcon: "cloud.sun.fill"),
        DummyChartRow(time: "03:00 PM", windSpeed: "6.2m/s", windDirection: 60, waveHeight: "2.5m", wavePeriod: "9.0s", waveDirection: 200, waterTemperature: "23.0°C", airTemperature: "26.0°C", weatherIcon: "cloud.sun.fill"),
        DummyChartRow(time: "06:00 PM", windSpeed: "4.8m/s", windDirection: 30, waveHeight: "1.8m", wavePeriod: "11.0s", waveDirection: 170, waterTemperature: "21.5°C", airTemperature: "24.5°C", weatherIcon: "cloud.rain.fill")
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 0) {
                        // 더미 데이터 배열을 사용하여 차트 행 생성
                        ForEach(dummyData.indices, id: \.self) { index in
                            let row = dummyData[index]
                            ZStack {
                                Color.white.opacity(0.8)
                                    .frame(height: 58)
                                HStack(spacing: 20) {
                                    
                                    // 시간 데이터
                                    VStack(spacing: 0) {
                                        Text(row.time)
                                            .font(.CaptionMedium)
                                            .foregroundColor(.black)
                                            .opacity(0.7)
                                    }
                                    
                                    // 바람 데이터
                                    HStack(spacing: 5) {
                                        Image(systemName: "paperplane")
                                            .foregroundColor(Color("iconSkyblue"))
                                            .rotationEffect(Angle(degrees: row.windDirection))  // 더미 회전 각도
                                        Text(row.windSpeed)  // 더미 바람 속도
                                            .font(.CaptionMedium)
                                    }
                                    
                                    // 파도 데이터
                                    HStack(spacing: 5) {
                                        Image(systemName: "paperplane.fill")
                                            .foregroundColor(Color("surfBlue"))
                                            .rotationEffect(Angle(degrees: row.waveDirection))  // 더미 회전 각도
                                        VStack(spacing: 0) {
                                            Text(row.waveHeight)  // 더미 파도 높이
                                                .font(.CaptionMedium)
                                            Text(row.wavePeriod)  // 더미 파도 주기
                                                .font(.CaptionMedium)
                                        }
                                    }
                                    
                                    // 수온 데이터
                                    VStack(spacing: 0) {
                                        Text(row.waterTemperature)  // 더미 수온
                                            .font(.Body2Medium)
                                        Image(systemName: "water.waves")
                                            .foregroundColor(Color("iconPurple"))
                                    }
                                    
                                    // 날씨 및 기온 데이터
                                    HStack(spacing: 5) {
                                        Image(systemName: row.weatherIcon)
                                            .foregroundColor(.gray)
                                        Text(row.airTemperature)  // 더미 기온
                                            .font(.Body2Medium)
                                    }
                                }
                                
                                // Divider 설정: 행 간 구분선 추가
                                if (dummyData.count > 3) {
                                    if (index < dummyData.count - 1) {
                                        Divider()
                                            .background(Color("surfBlue"))
                                            .padding(.top, 58)
                                    }
                                } else {
                                    if (index == 0 || index == 1) {
                                        Divider()
                                            .background(Color("surfBlue"))
                                            .padding(.top, 58)
                                    }
                                }
                            }
                        }
                    }
                }
                .scrollDisabled(oldViewModel.isChartScroll)
            }
        }
        .frame(height: 174)
    }
}

// 더미 데이터 구조체 정의
struct DummyChartRow {
    let time: String
    let windSpeed: String
    let windDirection: Double
    let waveHeight: String
    let wavePeriod: String
    let waveDirection: Double
    let waterTemperature: String
    let airTemperature: String
    let weatherIcon: String
}
