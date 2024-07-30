import SwiftUI

struct FitChartView: View {
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("surfBlue"), Color("bgGradiantWhite")]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            VStack(spacing: 0){
                HStack{
                    Button{
                        
                    }label: {
                        Text("포항 신항만 해변A")
                            .font(.SubheadingSemiBold)
                            .foregroundColor(.white)
                        Image(systemName: "arrow.down")
                            .foregroundColor(.white)
                    }
                    .opacity(0.7)
                    .padding(.horizontal, 12)
                    Spacer()
                }.padding(.bottom, 14)
                
                TabView{
                    // MARK: - 통계차트
                    VStack(alignment: .leading, spacing:0){
                        HStack {
                            Text("내가 선호하는 맞춤 수치")
                                .font(.Heading3Bold)
                                .foregroundColor(.white)
                            Spacer()
                            Button {
                                print("자세히 보기")
                            } label: {
                               Text("자세히 보기 >")
                                    .foregroundColor(.white)
                            }
                        }.padding(.bottom, 24)
                        .padding(.top, 20)
                        
                        HStack(spacing:0){
                            ZStack{
                                VStack(alignment: .leading, spacing:0){
                                    HStack{
                                        Image(systemName: "circle")
                                            .foregroundColor(Color("surfBlue"))
                                        
                                        Text("바람")
                                            .font(.Body1Bold)
                                            .foregroundColor(Color("surfBlue"))                                }
                                    .padding(.bottom, 34)
                                    HStack(spacing:0){
                                        Text("0.2m")
                                            .font(.Heading1SemiBold)
                                            .foregroundColor(Color("surfBlue"))
                                        Spacer()
                                        Image("waveDirectionIcon2")
                                            .foregroundColor(Color("surfBlue"))
                                        
                                    }
                                }.padding(12)
                                    .frame(minHeight: 139)
                            }
                            .background(.white.opacity(0.5))
                            .cornerRadius(24)
                            Spacer()
                                .frame(width: 13)
                            ZStack{
                                VStack(alignment: .leading, spacing:0){
                                    HStack{
                                        Image(systemName: "circle")
                                            .foregroundColor(Color("surfBlue"))
                                        
                                        Text("파도")
                                            .font(.Body1Bold)
                                            .foregroundColor(Color("surfBlue"))
                                        Spacer()
                                    }
                                    .padding(.bottom, 9)
                                    Text("0.2m")
                                        .font(.Heading1SemiBold)
                                        .foregroundColor(Color("surfBlue"))
                                    HStack(alignment: .bottom) {
                                        Text("3.3m/s")
                                            .font(.SubheadingSemiBold)
                                            .foregroundColor(Color("surfBlue"))
                                        Spacer()
                                        Image("swellDirectionIcon2")
                                            .foregroundColor(Color("surfBlue"))
                                    }
                                }.padding(12)
                                    .frame(minHeight: 139)
                            }
                            .background(.white.opacity(0.5))
                            .cornerRadius(24)
                        }
                        .padding(.top)
                        Spacer()
                    }
                    .padding(.bottom,15)
                    .padding(.horizontal, 20)
                 
                    
                    // MARK: - 최근차트
                    VStack(spacing: 0){
                        HStack{
                            Text("최근 기록 차트")
                                .font(.Heading3Bold)
                                .foregroundColor(.white)
                            Spacer()
                            Button{
                                
                            } label: {
                                Text("자세히 보기")
                                    .font(.Body2SemiBold)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.bottom, 12)
                        
                        ZStack{
                            Color.white.opacity(0.8)
                                .frame(height: 50)
                            HStack(spacing: 20){
                                VStack(spacing: 0){
                                    Text("7/26")
                                        .font(.Body2Bold)
                                        .foregroundColor(.surfBlue)
                                    Text("03시")
                                        .font(.CaptionMedium)
                                        .foregroundColor(Color("surfBlue"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane")
                                        .foregroundColor(Color("iconGreen"))
                                    Text("3.3m/s")
                                        .font(.Body2Medium)
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane.fill")
                                        .foregroundColor(Color("iconBlue"))
                                    VStack(spacing: 0){
                                        Text("0.2m")
                                            .font(.Body2Medium)
                                        Text("3.3m/s")
                                            .font(.CaptionMedium)
                                    }
                                }
                                VStack(spacing: 0){
                                    Text("28°C")
                                        .font(.Body2Medium)
                                    Image(systemName: "water.waves")
                                        .foregroundColor(Color("iconWaterOrange"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color("iconStarOrange"))
                                    Text("5")
                                        .font(.Body2SemiBold)
                                }
                            }
                        }
                        .cornerRadius(24)
                        .padding(.bottom, 4)
                       
                        ZStack{
                            Color.white.opacity(0.8)
                                .frame(height: 50)
                            HStack(spacing: 20){
                                VStack(spacing: 0){
                                    Text("7/26")
                                        .font(.Body2Bold)
                                        .foregroundColor(.surfBlue)
                                    Text("03시")
                                        .font(.CaptionMedium)
                                        .foregroundColor(Color("surfBlue"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane")
                                        .foregroundColor(Color("iconGreen"))
                                    Text("3.3m/s")
                                        .font(.Body2Medium)
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane.fill")
                                        .foregroundColor(Color("iconBlue"))
                                    VStack(spacing: 0){
                                        Text("0.2m")
                                            .font(.Body2Medium)
                                        Text("3.3m/s")
                                            .font(.CaptionMedium)
                                    }
                                }
                                VStack(spacing: 0){
                                    Text("28°C")
                                        .font(.Body2Medium)
                                    Image(systemName: "water.waves")
                                        .foregroundColor(Color("iconWaterOrange"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color("iconStarOrange"))
                                    Text("5")
                                        .font(.Body2SemiBold)
                                }
                            }
                        }
                        .cornerRadius(24)
                        .padding(.bottom, 4)
                        
                        ZStack{
                            Color.white.opacity(0.8)
                                .frame(height: 50)
                            HStack(spacing: 20){
                                VStack(spacing: 0){
                                    Text("7/26")
                                        .font(.Body2Bold)
                                        .foregroundColor(.surfBlue)
                                    Text("03시")
                                        .font(.CaptionMedium)
                                        .foregroundColor(Color("surfBlue"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane")
                                        .foregroundColor(Color("iconGreen"))
                                    Text("3.3m/s")
                                        .font(.Body2Medium)
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane.fill")
                                        .foregroundColor(Color("iconBlue"))
                                    VStack(spacing: 0){
                                        Text("0.2m")
                                            .font(.Body2Medium)
                                        Text("3.3m/s")
                                            .font(.CaptionMedium)
                                    }
                                }
                                VStack(spacing: 0){
                                    Text("28°C")
                                        .font(.Body2Medium)
                                    Image(systemName: "water.waves")
                                        .foregroundColor(Color("iconWaterOrange"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color("iconStarOrange"))
                                    Text("5")
                                        .font(.Body2SemiBold)
                                }
                            }
                        }
                        .cornerRadius(24)
                        .padding(.bottom, 4)
                        
                        
                    }
                    .padding(.horizontal, 20)
                    
                    // MARK: - 고정 차트
                    VStack(spacing: 0){
                        HStack{
                            Text("나의 고정 차트")
                                .font(.Heading3Bold)
                                .foregroundColor(.white)
                            Spacer()
                            Button{
                                
                            } label: {
                                Text("모두보기")
                                    .font(.Body2SemiBold)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.bottom, 12)
                        
                        ZStack{
                            Color.white.opacity(0.8)
                                .frame(height: 50)
                            HStack(spacing: 20){
                                VStack(spacing: 0){
                                    Text("7/26")
                                        .font(.Body2Bold)
                                        .foregroundColor(.surfBlue)
                                    Text("03시")
                                        .font(.CaptionMedium)
                                        .foregroundColor(Color("surfBlue"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane")
                                        .foregroundColor(Color("iconGreen"))
                                    Text("3.3m/s")
                                        .font(.Body2Medium)
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane.fill")
                                        .foregroundColor(Color("iconBlue"))
                                    VStack(spacing: 0){
                                        Text("0.2m")
                                            .font(.Body2Medium)
                                        Text("3.3m/s")
                                            .font(.CaptionMedium)
                                    }
                                }
                                VStack(spacing: 0){
                                    Text("28°C")
                                        .font(.Body2Medium)
                                    Image(systemName: "water.waves")
                                        .foregroundColor(Color("iconWaterOrange"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color("iconStarOrange"))
                                    Text("5")
                                        .font(.Body2SemiBold)
                                }
                            }
                        }
                        .cornerRadius(24)
                        .padding(.bottom, 4)
                        ZStack{
                            Color.white.opacity(0.8)
                                .frame(height: 50)
                            HStack(spacing: 20){
                                VStack(spacing: 0){
                                    Text("7/26")
                                        .font(.Body2Bold)
                                        .foregroundColor(.surfBlue)
                                    Text("03시")
                                        .font(.CaptionMedium)
                                        .foregroundColor(Color("surfBlue"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane")
                                        .foregroundColor(Color("iconGreen"))
                                    Text("3.3m/s")
                                        .font(.Body2Medium)
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane.fill")
                                        .foregroundColor(Color("iconBlue"))
                                    VStack(spacing: 0){
                                        Text("0.2m")
                                            .font(.Body2Medium)
                                        Text("3.3m/s")
                                            .font(.CaptionMedium)
                                    }
                                }
                                VStack(spacing: 0){
                                    Text("28°C")
                                        .font(.Body2Medium)
                                    Image(systemName: "water.waves")
                                        .foregroundColor(Color("iconWaterOrange"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color("iconStarOrange"))
                                    Text("5")
                                        .font(.Body2SemiBold)
                                }
                            }
                        }
                        .cornerRadius(24)
                        .padding(.bottom, 4)
                        ZStack{
                            Color.white.opacity(0.8)
                                .frame(height: 50)
                            HStack(spacing: 20){
                                VStack(spacing: 0){
                                    Text("7/26")
                                        .font(.Body2Bold)
                                        .foregroundColor(.surfBlue)
                                    Text("03시")
                                        .font(.CaptionMedium)
                                        .foregroundColor(Color("surfBlue"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane")
                                        .foregroundColor(Color("iconGreen"))
                                    Text("3.3m/s")
                                        .font(.Body2Medium)
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "paperplane.fill")
                                        .foregroundColor(Color("iconBlue"))
                                    VStack(spacing: 0){
                                        Text("0.2m")
                                            .font(.Body2Medium)
                                        Text("3.3m/s")
                                            .font(.CaptionMedium)
                                    }
                                }
                                VStack(spacing: 0){
                                    Text("28°C")
                                        .font(.Body2Medium)
                                    Image(systemName: "water.waves")
                                        .foregroundColor(Color("iconWaterOrange"))
                                }
                                HStack(spacing: 0){
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color("iconStarOrange"))
                                    Text("5")
                                        .font(.Body2SemiBold)
                                }
                            }
                        }
                        .cornerRadius(24)
                        .padding(.bottom, 4)
                    }
                    .padding(.bottom,34)
                    .padding(.horizontal, 20)
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                 // .never 로 하면 배경 안보이고 .always 로 하면 인디케이터 배경 보입니다.
                
//                .background(.gray.opacity(0.6))
//                VStack(spacing: 0){
//                    Divider()
//                        .padding(.bottom, 470)
//                        .background(.white)
//                        
//                }
            }
        }
    }
}

#Preview {
    FitChartView()
}
