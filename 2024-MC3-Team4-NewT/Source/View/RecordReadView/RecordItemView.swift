import SwiftUI
import SwiftData

struct RecordItemView: View {
    var item: SurfingRecordOne
    @ObservedObject var viewModel: RecordChartViewModel
    @Environment(\.modelContext) var modelContext
    @State private var showDeleteConfirmation = false
    
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white
            VStack(spacing: 0) {
                VStack {
                    HStack {
                        Text(DateFormatterManager.shared.dateFormatter(from: item.surfingStartTime))
                            .font(.SubheadingBold)
                            .foregroundColor(Color("surfBlue"))
                        Spacer()
                        Button {
                            withAnimation {
                                viewModel.updateEllipsisState(for: item.id)
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28)
                                .foregroundColor(.black)
                        }
                    }
                    HStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Image(systemName: "star.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 13)
                                .foregroundColor(Color("surfBlue"))
                            Text(" \(item.evaluationValue)점, ")
                                .font(.Body2SemiBold)
                                .foregroundColor(.black.opacity(0.7))
                            Text(viewModel.evaluationText(for: item.evaluationValue))
                                .font(.Body2Medium)
                                .foregroundColor(.black.opacity(0.7))
                        }
                        .padding(5)
                        .background(.white.opacity(0.6))
                        .cornerRadius(12)
                        Spacer()
                        if item.memo.isEmpty {
                            Button {
                                viewModel.chartRowId = item.id
                                // 메모 추가하기 눌렀을 때 보이는 화면 만들어야 함!!
                            } label: {
                                Text("메모 추가하기 ")
                                    .font(.CaptionMedium)
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 12)
                            }
                            .foregroundColor(Color.black.opacity(0.5))
                        } else {
                            Button {
                                viewModel.ismemo.toggle()
                                viewModel.chartRowId = item.id
                            } label: {
                                Text("메모 확인하기 ")
                                    .font(.CaptionMedium)
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 12)
                            }
                            .foregroundColor(Color.black.opacity(0.8))
                            .sheet(isPresented: $viewModel.ismemo) {
                                ModalView(viewModel: viewModel)
                                    .presentationDetents([.fraction(0.8)])
                            }
                        }
                    }
                }
                .padding(.top)
                .padding(.bottom)
                .padding(.horizontal)
                .background(Color("backgroundSkyblue"))
                
                RecordChartTestView(viewModel: viewModel, recordOne: item)
            }
            
            if viewModel.isEllipsisOnOff[item.id] == true {
                HStack {
                    Spacer()
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                        VStack(alignment: .leading, spacing: 0) {
                            Button {
                                print("recordId:\(item.id)")
                                print("쇼핀:\(viewModel.showPin)")
                                viewModel.recordId = item.id
                                viewModel.isPinButton[item.id, default: false].toggle()
                                viewModel.isEllipsisOnOff[item.id, default: false].toggle()
                            } label: {
                                HStack {
                                    Text("핀 고정")
                                    Spacer()
                                    Image(systemName: "pin")
                                }
                                .foregroundColor(.black)
                                .frame(width: 218, height: 44)
                                .padding(.leading)
                            }
                            
                            Divider()
                            Button {
                                // Your edit action here
                            } label: {
                                HStack {
                                    Text("수정")
                                    Spacer()
                                    Image(systemName: "pencil")
                                }
                                .foregroundColor(.black)
                                .frame(width: 218, height: 44)
                                .padding(.leading)
                            }
                            
                            Divider()
                            Button {
                                showDeleteConfirmation = true
                                deleteRecord(item: item)// Show the delete confirmation alert
                            } label: {
                                HStack {
                                    Text("삭제")
                                    Spacer()
                                    Image(systemName: "trash")
                                }
                                .foregroundColor(.red)
                                .frame(width: 218, height: 44)
                                .padding(.leading)
                            }
                        }
                    }
                    .frame(width: 250, height: 132)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                    .padding(.top, 47)
                    .padding(.trailing, 16)
                }
            }
        }
        .cornerRadius(24)
        .padding(.horizontal)
        .padding(.bottom)
        .alert(isPresented: $showDeleteConfirmation) {
            Alert(
                title: Text("기록을 삭제하시겠습니까?"),
                primaryButton: .destructive(Text("삭제")) {
                    deleteRecord(item: item)
                },
                secondaryButton: .cancel(Text("취소"))
            )
        }
        .alert(isPresented: $viewModel.showPin) {
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

//        .alert(isPresented: $viewModel.isRecord) {
//            Alert(
//                title: Text("이미 등록된 차트입니다."),
//                dismissButton: .default(Text("취소")) {
//                    print("test")
//
//                    viewModel.isChartPinButton[viewModel.chartRowId] = false
//                    //                    viewModel.isEllipsisOnOff[viewModel.recordId] = false
//                    viewModel.isPinButton[viewModel.recordId] = false
//                    viewModel.showPin = false
//                    viewModel.isRecord = false
//                }
//            )
//        }
        
    }
    // 기록 삭제 함수
    func deleteRecord(item: SurfingRecordOne) {
        modelContext.delete(item)
        try? modelContext.save()
    }
    
    
}
