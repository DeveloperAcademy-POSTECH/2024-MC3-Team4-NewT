import SwiftUI
import SwiftData

struct RecordItemView: View {
    var item: SurfingRecordOne
    @ObservedObject var viewModel: RecordChartViewModel
    @Environment(\.modelContext) var modelContext // Access the SwiftData context
//    @Query var pinModel:[Pin]
    @State private var showDeleteConfirmation = false // State to show the confirmation alert

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
                                viewModel.isID = item.id
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
                                viewModel.isID = item.id
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
                                item.charts.first?.isHighTide = true
                               
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
                                showDeleteConfirmation = true // Show the delete confirmation alert
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
    }
    
    private func deleteRecord(item: SurfingRecordOne) {
        modelContext.delete(item) // Delete the SurfingRecordOne object from the context
        try? modelContext.save()  // Save the context to persist changes
    }
}
