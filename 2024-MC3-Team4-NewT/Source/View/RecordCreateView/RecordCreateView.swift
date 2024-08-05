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
                                ChartHeaderView(viewModel: viewModel)
                                
                                ChartView(
                                    viewModel: viewModel,
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
                    viewModel:viewModel,
                    observable: cro
                )
                
                Spacer()
            }
        }
        .navigationTitle("파도 기록")
        
    }
}
