import SwiftUI

struct FitChartView: View {
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("surfBlue"), Color.white]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            VStack(spacing: 0){
                HStack{
                    Button{
                        
                    }label: {
                        Text("포항 신항만 해변A")
                            .font(.pretendardBold18) //왜 두껍지가 않지?
                            .foregroundColor(.white)
                        Image(systemName: "arrow.down")
                            .foregroundColor(.white)
                    }
                    .opacity(0.7)
                    .padding(.horizontal, 20)
                    Spacer()
                }.padding(.bottom, 14)
                
                TabView{
                    // MARK: - 통계차트
                    VStack(spacing:0){
                        HStack{
                            Text("내가 선호하는 맞춤 차트")
                                .font(.pretendardBold21)
                                .foregroundColor(.white)
                            Spacer()
                        }.padding(.bottom, 16)
                        
                        HStack(spacing:0){
                            ZStack{
                                Color.white
                                VStack(alignment: .leading, spacing:0){
                                    HStack{
                                        Image(systemName: "circle")
                                            .foregroundColor(Color("surfBlue"))
                                        
                                        Text("바람")
                                            .font(.pretendardBold18)
                                            .foregroundColor(Color("surfBlue"))                                }
                                    .padding(.bottom, 34)
                                    HStack(spacing:0){
                                        Text("0.2m")
                                            .font(.pretendardBold24)
                                            .foregroundColor(Color("surfBlue"))
                                        Spacer()
                                        Image(systemName: "paperplane")
                                            .foregroundColor(Color("surfBlue"))
                                        
                                    }
                                }.padding(.horizontal, 12)
                            }
                            .cornerRadius(24)
                            Spacer()
                                .frame(width: 13)
                            ZStack{
                                Color.white
                                VStack(alignment: .leading, spacing:0){
                                    HStack{
                                        Image(systemName: "circle")
                                            .foregroundColor(Color("surfBlue"))
                                        
                                        Text("파도")
                                            .font(.pretendardBold18)
                                            .foregroundColor(Color("surfBlue"))
                                        Spacer()
                                    }
                                    .padding(.bottom, 9)
                                    Text("0.2m")
                                        .font(.pretendardBold24)
                                        .foregroundColor(Color("surfBlue"))
                                    HStack(alignment: .bottom) {
                                        Text("3.3m/s")
                                            .font(.pretendardSemiBold18)
                                            .foregroundColor(Color("surfBlue"))
                                        Spacer()
                                        Image(systemName: "paperplane.fill")
                                            .foregroundColor(Color("surfBlue"))
                                    }
                                }.padding(.horizontal, 12)
                            }
                            .cornerRadius(24)
                        }
                        .padding(.top)

                    }
                    .padding(.bottom,76)
                    .padding(.horizontal, 20)
                 
                    
                    // MARK: - 최근차트
                    VStack(spacing: 0){
                        HStack{
                            Text("최근 차트 기록")
                                .font(.pretendardBold21)
                                .foregroundColor(.white)
                            Spacer()
                            Button{
                                
                            } label: {
                                Text("모두보기")
                                    .font(.pretendardBold12)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.bottom, 12)
                        
                        ZStack{
                            Color.white.opacity(0.8)
                            HStack(spacing: 20){
                                VStack(spacing: 0){
                                    Text("7/26")
                                        .font(.pretendardSemiBold14)
                                    Text("03시")
                                        .font(.pretendardMedium12)
                                        .foregroundColor(Color("surfBlue"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane")
                                        .foregroundColor(Color("iconGreen"))
                                    Text("3.3m/s")
                                        .font(.pretendardMedium14)
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane.fill")
                                        .foregroundColor(Color("iconBlue"))
                                    VStack(spacing: 0){
                                        Text("0.2m")
                                            .font(.pretendardMedium14)
                                        Text("3.3m/s")
                                            .font(.pretendardMedium12)
                                    }
                                }
                                VStack(spacing: 0){
                                    Text("28°C")
                                        .font(.pretendardMedium14)
                                    Image(systemName: "water.waves")
                                        .foregroundColor(Color("iconWaterOrange"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color("iconStarOrange"))
                                    Text("5")
                                        .font(.pretendardMedium14)
                                }
                            }
                        }
                        .cornerRadius(24)
                        .padding(.bottom, 4)
                       
                        ZStack{
                            Color.white.opacity(0.8)
                            HStack(spacing: 20){
                                VStack(spacing: 0){
                                    Text("7/26")
                                        .font(.pretendardSemiBold14)
                                    Text("03시")
                                        .font(.pretendardMedium12)
                                        .foregroundColor(Color("surfBlue"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane")
                                        .foregroundColor(Color("iconGreen"))
                                    Text("3.3m/s")
                                        .font(.pretendardMedium14)
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane.fill")
                                        .foregroundColor(Color("iconBlue"))
                                    VStack(spacing: 0){
                                        Text("0.2m")
                                            .font(.pretendardMedium14)
                                        Text("3.3m/s")
                                            .font(.pretendardMedium12)
                                    }
                                }
                                VStack(spacing: 0){
                                    Text("28°C")
                                        .font(.pretendardMedium14)
                                    Image(systemName: "water.waves")
                                        .foregroundColor(Color("iconWaterOrange"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color("iconStarOrange"))
                                    Text("5")
                                        .font(.pretendardMedium14)
                                }
                            }
                        }
                        .cornerRadius(24)
                        .padding(.bottom, 4)
                        
                        ZStack{
                            Color.white.opacity(0.8)
                            HStack(spacing: 20){
                                VStack(spacing: 0){
                                    Text("7/26")
                                        .font(.pretendardSemiBold14)
                                    Text("03시")
                                        .font(.pretendardMedium12)
                                        .foregroundColor(Color("surfBlue"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane")
                                        .foregroundColor(Color("iconGreen"))
                                    Text("3.3m/s")
                                        .font(.pretendardMedium14)
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane.fill")
                                        .foregroundColor(Color("iconBlue"))
                                    VStack(spacing: 0){
                                        Text("0.2m")
                                            .font(.pretendardMedium14)
                                        Text("3.3m/s")
                                            .font(.pretendardMedium12)
                                    }
                                }
                                VStack(spacing: 0){
                                    Text("28°C")
                                        .font(.pretendardMedium14)
                                    Image(systemName: "water.waves")
                                        .foregroundColor(Color("iconWaterOrange"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color("iconStarOrange"))
                                    Text("5")
                                        .font(.pretendardMedium14)
                                }
                            }
                        }
                        .cornerRadius(24)
                        .padding(.bottom, 4)
                    }
                    .padding(.bottom,34)
                    .padding(.horizontal, 20)
                    
                    // MARK: - 고정 차트
                    VStack(spacing: 0){
                        HStack{
                            Text("고정 차트 기록")
                                .font(.pretendardBold21)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            Spacer()
                        }.padding(.bottom, 12)
                        
                        ZStack{
                            Color.white.opacity(0.8)
                            HStack(spacing: 20){
                                VStack(spacing: 0){
                                    Text("7/26")
                                        .font(.pretendardSemiBold14)
                                    Text("03시")
                                        .font(.pretendardMedium12)
                                        .foregroundColor(Color("surfBlue"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane")
                                        .foregroundColor(Color("iconGreen"))
                                    Text("3.3m/s")
                                        .font(.pretendardMedium14)
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane.fill")
                                        .foregroundColor(Color("iconBlue"))
                                    VStack(spacing: 0){
                                        Text("0.2m")
                                            .font(.pretendardMedium14)
                                        Text("3.3m/s")
                                            .font(.pretendardMedium12)
                                    }
                                }
                                VStack(spacing: 0){
                                    Text("28°C")
                                        .font(.pretendardMedium14)
                                    Image(systemName: "water.waves")
                                        .foregroundColor(Color("iconWaterOrange"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color("iconStarOrange"))
                                    Text("5")
                                        .font(.pretendardMedium14)
                                }
                            }
                        }
                        .cornerRadius(24)
                        .padding(.horizontal)
                        .padding(.bottom, 4)
                       
                        ZStack{
                            Color.white.opacity(0.8)
                            HStack(spacing: 20){
                                VStack(spacing: 0){
                                    Text("7/26")
                                        .font(.pretendardSemiBold14)
                                    Text("03시")
                                        .font(.pretendardMedium12)
                                        .foregroundColor(Color("surfBlue"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane")
                                        .foregroundColor(Color("iconGreen"))
                                    Text("3.3m/s")
                                        .font(.pretendardMedium14)
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane.fill")
                                        .foregroundColor(Color("iconBlue"))
                                    VStack(spacing: 0){
                                        Text("0.2m")
                                            .font(.pretendardMedium14)
                                        Text("3.3m/s")
                                            .font(.pretendardMedium12)
                                    }
                                }
                                VStack(spacing: 0){
                                    Text("28°C")
                                        .font(.pretendardMedium14)
                                    Image(systemName: "water.waves")
                                        .foregroundColor(Color("iconWaterOrange"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color("iconStarOrange"))
                                    Text("5")
                                        .font(.pretendardMedium14)
                                }
                            }
                        }
                        .cornerRadius(24)
                        .padding(.horizontal)
                        .padding(.bottom, 4)
                        
                        ZStack{
                            Color.white.opacity(0.8)
                            HStack(spacing: 20){
                                VStack(spacing: 0){
                                    Text("7/26")
                                        .font(.pretendardSemiBold14)
                                    Text("03시")
                                        .font(.pretendardMedium12)
                                        .foregroundColor(Color("surfBlue"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane")
                                        .foregroundColor(Color("iconGreen"))
                                    Text("3.3m/s")
                                        .font(.pretendardMedium14)
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane.fill")
                                        .foregroundColor(Color("iconBlue"))
                                    VStack(spacing: 0){
                                        Text("0.2m")
                                            .font(.pretendardMedium14)
                                        Text("3.3m/s")
                                            .font(.pretendardMedium12)
                                    }
                                }
                                VStack(spacing: 0){
                                    Text("28°C")
                                        .font(.pretendardMedium14)
                                    Image(systemName: "water.waves")
                                        .foregroundColor(Color("iconWaterOrange"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color("iconStarOrange"))
                                    Text("5")
                                        .font(.pretendardMedium14)
                                }
                            }
                        }
                        .cornerRadius(24)
                        .padding(.horizontal)
                        .padding(.bottom, 4)
                    }
                    .padding(.bottom,34)
                    .padding(.horizontal, 20)
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                 // .never 로 하면 배경 안보이고 .always 로 하면 인디케이터 배경 보입니다.
                
//                .background(.gray.opacity(0.6))
                VStack(spacing: 0){
                    Divider()
                        .padding(.bottom, 470)
                        .background(.white)
                        
                }
            }
        }
    }
}

#Preview {
    FitChartView()
}
