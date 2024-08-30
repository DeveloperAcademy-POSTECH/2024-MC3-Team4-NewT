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
    @ObservedObject var newViewModel: NewRecordCreateViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 0) {
                        // newViewModel의 데이터를 사용하여 차트 행 생성
                        ForEach(newViewModel.SDDailySurfingValues.indices, id: \.self) { index in
                            let row = newViewModel.SDDailySurfingValues[index]
                            ZStack {
                                Color.white.opacity(0.8)
                                    .frame(height: 58)
                                HStack(spacing: 20) {
                                    
                                    // 시간 데이터
                                    VStack(spacing: 0) {
                                        Text(row.time)  // 시간 데이터를 사용
                                            .font(.CaptionMedium)
                                            .foregroundColor(.black)
                                            .opacity(0.7)
                                    }
                                    
                                    // 바람 데이터
                                    HStack(spacing: 5) {
                                        Image(systemName: "paperplane")
                                            .foregroundColor(Color("iconSkyblue"))
                                            .rotationEffect(Angle(degrees: Double(row.windDirection)))  // 바람 방향
                                        Text("\(row.windSpeed, specifier: "%.1f")m/s")  // 바람 속도
                                            .font(.CaptionMedium)
                                    }
                                    
                                    // 파도 데이터
                                    HStack(spacing: 5) {
                                        Image(systemName: "paperplane.fill")
                                            .foregroundColor(Color("surfBlue"))
                                            .rotationEffect(Angle(degrees: Double(row.waveDirection)))  // 파도 방향
                                        VStack(spacing: 0) {
                                            Text("\(row.waveHeight, specifier: "%.1f")m")  // 파도 높이
                                                .font(.CaptionMedium)
                                            Text("\(row.wavePeriod, specifier: "%.1f")s")  // 파도 주기
                                                .font(.CaptionMedium)
                                        }
                                    }
                                    
                                    // 수온 데이터
                                    VStack(spacing: 0) {
                                        Text("\(row.waterTemperature, specifier: "%.1f")°C")  // 수온
                                            .font(.Body2Medium)
                                        Image(systemName: "water.waves")
                                            .foregroundColor(Color("iconPurple"))
                                    }
                                    
                                    // 날씨 및 기온 데이터
                                    HStack(spacing: 5) {
                                        Image(systemName: row.weather)  // 날씨 아이콘
                                            .foregroundColor(.gray)
                                        Text("\(row.airTemperature, specifier: "%.1f")°C")  // 기온
                                            .font(.Body2Medium)
                                    }
                                }
                                
                                // Divider 설정: 행 간 구분선 추가
                                if (newViewModel.SDDailySurfingValues.count > 3) {
                                    if (index < newViewModel.SDDailySurfingValues.count - 1) {
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
