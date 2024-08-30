//
//  ChartViewModel.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/29/24.
//

import SwiftUI
import Combine

class ChartViewModel: ObservableObject {
    @Published var timeWidth: Double = 40.0
    @Published var windWidth: Double = 80.0
    @Published var waveWidth: Double = 60.0
    @Published var waterWidth: Double = 40.0
    @Published var weatherWidth: Double = 70.0
}

