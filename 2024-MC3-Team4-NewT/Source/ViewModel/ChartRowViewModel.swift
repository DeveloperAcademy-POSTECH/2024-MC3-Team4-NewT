////
////  ChartRowViewModel.swift
////  2024-MC3-Team4-NewT
////
////  Created by 김이예은 on 7/29/24.
////
//
//import SwiftUI
//import SwiftData
//
//class ChartRowViewModel: ObservableObject {
//    @Published var chartRows: [ChartRow] = []
//
//    func loadChartRows() {
//        fetchChartRows { [weak self] rows in
//            DispatchQueue.main.async {
//                self?.chartRows = rows
//            }
//        }
//    }
//    
//    func fetchChartRows(completion: @escaping ([ChartRow]) -> Void) {
//        let urlString = "https://api.example.com/chartrows" // 실제 API URL로 변경
//        guard let url = URL(string: urlString) else { return }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let surfingValues = try decoder.decode([SurfingValues].self, from: data)
//                let chartRows = surfingValues.map { SurfingValues in
//                    ChartRow(surfingValues: SurfingValues)
//                }
//                completion(chartRows)
//            } catch {
//                print("Error decoding data: \(error.localizedDescription)")
//            }
//        }
//        task.resume()
//    }
//}
