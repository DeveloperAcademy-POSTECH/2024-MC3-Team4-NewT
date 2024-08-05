//
//  RecordCreateView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/5/24.

import SwiftUI
import SwiftData

struct RecordCreateView: View {
    @Environment(\.modelContext) var modelContext
    @ObservedObject var viewModel = RecordCreateViewModel()
    var cro = ChartRecordObservable()
    
    var body: some View {
        
        ZStack(alignment: .top){
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            VStack(spacing: 0){
                ScrollView{
                    VStack{
                        ZStack(alignment: .top){
                            Color.white
                            VStack(spacing: 0){
                                TimePickerView(viewModel: viewModel)
                                
                                Divider()
                                    .padding(.leading)
                                Text(DateFormatterManager.shared.date(from: viewModel.selectedDate))
                                    .font(.SubheadingBold)
                                    .foregroundStyle(Color("surfBlue"))
                                    .padding(.vertical, 8)
                                ZStack{
                                    Rectangle()
                                        .frame(height: 20)
                                        .foregroundColor(Color(.systemGroupedBackground))
                                    HStack(spacing: 50){
                                        Text("시간")
                                        Text("바람")
                                        Text("파도")
                                        Text("수온")
                                        Text("날씨")
                                    }
                                    .font(.CaptionMedium)
                                    .foregroundColor(Color(.black).opacity(0.5))
                                }
                                ChartView(
                                    viewModel: viewModel,  // 여기서 viewModel을 전달합니다.
                                    isChartScroll: $viewModel.isChartScroll,
                                    observable: cro
                                )
                                
                            }
                        }
                        .cornerRadius(24)
                        .padding(.horizontal)
                        
                        
                        EvaluationView(
                            viewModel:viewModel
                        )
                        .frame(height: viewModel.heightSize)
                        .cornerRadius(24)
                        .padding(.horizontal)
                        
                    }
                }.scrollDisabled(viewModel.isMemo)
                    .padding(.bottom)
                
                
                RecordButtonView(
                    viewModel:viewModel
                )
                
                Spacer()
            }
        }
        .navigationTitle("파도 기록")
        
    }
  
}

