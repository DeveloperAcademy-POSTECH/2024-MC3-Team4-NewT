import SwiftUI
import SwiftData

struct ModalView: View {
    @Query private var surfingRecordOneData: [SurfingRecordOne]
    @ObservedObject var viewModel : RecordChartViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView{
            ForEach(surfingRecordOneData, id: \.id) { item in
                if ( item.id == viewModel.isID) {
                    VStack(spacing: 0){
                        HStack{
                            Text(DateFormatterManager.shared.dateFormatter(from: item.surfingStartTime))
                                .font(.Heading3Bold)
                                .foregroundColor(Color("surfBlue"))
                            Spacer()
                            Button{
                                //모달 내리기 모션 넣어야함
                                dismiss()
                            }label: {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 28)
                                    .foregroundColor(.gray)
                            }
                        }.padding(.bottom, 20)
                        
                        HStack(spacing: 0) {
                            HStack(spacing: 0){
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 13)
                                    .foregroundColor(Color("surfBlue"))
                                Text("\(item.evaluationValue)점, ")
                                    .font(.Body2SemiBold)
                                    .foregroundColor(.black.opacity(0.7))
                                
                                Text(viewModel.evaluationText(for: item.evaluationValue))
                                    .font(.Body2Medium)
                                    .foregroundColor(.black.opacity(0.7))
                               
                            }
                            .padding(5)
                            .background(Color("backgroundSkyblue"))
                            .cornerRadius(12)
                            Spacer()
                        }.padding(.bottom, 12)
                        
                        HStack(spacing: 0){
                            Text(item.memo)
                            
                            
                            Spacer()
                        }.padding(.bottom, 36)
                        
                        RecordChartTestView(viewModel: viewModel, recordOne: item)
                        
                    }.padding(.horizontal)
//                        .overlay(.yellow.opacity(0.3))
                        .padding(.vertical, 30)
                    
                }
            }
        }
    }
}
