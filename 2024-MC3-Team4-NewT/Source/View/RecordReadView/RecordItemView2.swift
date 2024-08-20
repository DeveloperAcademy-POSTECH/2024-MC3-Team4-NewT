//
//  RecordItemView2.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/13/24.
//
import SwiftUI
import SwiftData

struct RecordItemView2: View {
    var item: OldSurfingRecordOne
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
                                removePinRecord(for: item.surfingStartTime)
                                viewModel.updateEllipsisState(for: item.id)
                            } label: {
                                HStack {
                                    Text("핀 고정 제거")
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
                           
                        }
                    }
                    .frame(width: 250, height: 100)
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
       
    }
    
    private func removePinRecord(for startTime: Date) {
        var pinRecords = UserDefaults.standard.stringArray(forKey: "pinRecord") ?? []
        let convertDate = DateFormatterManager.shared.convertDateToString(date: startTime)
        
        if let index = pinRecords.firstIndex(of: convertDate) {
            pinRecords.remove(at: index)
            UserDefaults.standard.set(pinRecords, forKey: "pinRecord")
            print("Removed pin for Date: \(convertDate)")
        }
    }
}
