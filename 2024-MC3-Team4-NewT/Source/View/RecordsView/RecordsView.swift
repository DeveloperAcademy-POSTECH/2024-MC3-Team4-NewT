//ZStack(alignment: .top){
//    Color.white
//    VStack(spacing:0){
//        Spacer()
//            .frame(height: 16)
//        HStack(spacing: 0){
//            Text("오늘의 파도 평가")
//                .font(.SubheadingBold)
//                .foregroundColor(Color("surfBlue"))
//            Spacer()
//        }.padding(.bottom, 20)
//        
//        ZStack{
//            ProgressView(value: isScore, total: 4.0)
//                .tint(Color("surfBlue"))
//                .background(Color("brightGray"))
//            
//            HStack(spacing: 50){
//                ForEach(0..<5) { index in
//                    Button {
//                        selectedScore = index
//                        isScore = Double(index)
//                    } label: {
//                        Circle()
//                            .frame(width: 20, height: 20)
//                            .foregroundColor(selectedScore >= index ? Color("surfBlue") : Color(.systemGroupedBackground))
//                    }
//                }
//                
//            }
//        }
//        .frame(width: 296)
//        .padding(.bottom, 11)
//        
//        HStack(spacing: 0){
//            VStack{
//                Text("1점")
//                    .font(.Body2Bold)
//                    .foregroundColor(Color("surfBlue"))
//                Text("별로예요")
//                    .font(.CaptionMedium)
//                    .foregroundColor(Color("surfBlue"))
//            }
//            Spacer()
//            VStack{
//                Text("2점")
//                    .font(.Body2Bold)
//                    .foregroundColor(Color("surfBlue"))
//                Text("아쉬워요")
//                    .font(.CaptionMedium)
//                    .foregroundColor(Color("surfBlue"))
//            }
//            Spacer()
//            
//            VStack{
//                Text("3점")
//                    .font(.Body2Bold)
//                    .foregroundColor(Color("surfBlue"))
//                Text("보통이에요")
//                    .font(.CaptionMedium)
//                    .foregroundColor(Color("surfBlue"))
//            }
//            Spacer()
//            
//            VStack{
//                Text("4점")
//                    .font(.Body2Bold)
//                    .foregroundColor(Color("surfBlue"))
//                Text("만족해요")
//                    .font(.CaptionMedium)
//                    .foregroundColor(Color("surfBlue"))
//            }
//            Spacer()
//            
//            VStack{
//                Text("5점")
//                    .font(.Body2Bold)
//                    .foregroundColor(Color("surfBlue"))
//                Text("최고예요")
//                    .font(.CaptionMedium)
//                    .foregroundColor(Color("surfBlue"))
//            }
//        }
//        .padding(.bottom, 16)
//        HStack(spacing: 0){
//            Text("파도 코멘트")
//                .font(.SubheadingBold)
//                .foregroundColor(Color("surfBlue"))
//            Spacer()
//        }.padding(.bottom, 8)
//        
//        if isMemo{
//            Button{
//                isMemo.toggle()
//                heightSize = 322.0
//            } label: {
//                ZStack {
//                    Color.white
//                        .frame(height: 43)
//                        .cornerRadius(16)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 16)
//                                .stroke(Color("surfBlue"), lineWidth: 1.5)
//                        )
//                    HStack{
//                        Text("메모 추가")
//                            .font(.SubheadingSemiBold)
//                            .foregroundColor(Color("surfBlue"))
//                        Image(systemName: "plus.circle.fill")
//                            .foregroundColor(Color("surfBlue"))
//                    }
//                }
//            }
//        }
//        else {
//            ZStack(alignment: .top){
//                TextEditor(text: $memo)
//                    .frame(height: 120)
//                    .font(.Body1Medium)
//                    .foregroundColor(Color.black)
//                    .padding(5)
//                    .lineSpacing(5)
//                    .scrollContentBackground(.hidden)
//                    .background(Color("brightGray"))
//                    .cornerRadius(12)
//                    .onChange(of: memo){ newValue in
//                        if newValue.count > memoLimit {
//                            memo = String(newValue.prefix(memoLimit))
//                        }
//                    }
//                if(memo.isEmpty)
//                {
//                    VStack(spacing: 0){
//                        HStack(spacing: 0){
//                            Text(placeHolding)
//                                .font(.Body1Medium)                    .foregroundColor(Color.gray)
//                                .padding(.top, 13)
//                            
//                            Spacer()
//                        }
//                        HStack(spacing: 0){
//                            Text(placeHolding1)
//                                .font(.Body2Medium)
//                                .foregroundColor(Color.gray)
//                            Spacer()
//                        }
//                    }
//                    .padding(.horizontal, 13)
//                }
//            }
//        }
//    }
//    .padding(.horizontal)
//}
//.frame(height: heightSize)
//.cornerRadius(24)
//.padding(.horizontal)
