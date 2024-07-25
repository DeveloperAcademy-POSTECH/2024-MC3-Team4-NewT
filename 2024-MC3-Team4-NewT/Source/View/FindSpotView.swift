//
//  FindSpotView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/25/24.
//

import SwiftUI

struct FindSpotView: View {
    @State private var rawData: String = "Loading..."
    @State private var query: String = "Wolpo" // 검색할 지역명

    var body: some View {
        VStack {
            TextField("Enter location", text: $query)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                fetchData()
            }) {
                Text("Fetch Data")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            Text("Raw Data")
                .font(.headline)
                .padding()

            ScrollView {
                Text(rawData)
                    .padding()
                    .font(.body)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            .padding()
        }
    }

    func fetchData() {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            self.rawData = "Invalid query"
            return
        }

        let headers = [
            "x-rapidapi-key": "62c4c267cdmshb924eeea03c284dp1dc19bjsn24ad9fb78cc3",
            "x-rapidapi-host": "api-windfinder-pro.p.rapidapi.com"
        ]

        let urlString = "https://api-windfinder-pro.p.rapidapi.com/search/autocomplete/en/\(encodedQuery)"
        guard let url = URL(string: urlString) else {
            self.rawData = "Invalid URL"
            return
        }

        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) -> Void in
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    self.rawData = "Error: \(error.localizedDescription)"
                }
            } else if let data = data {
                let rawString = String(data: data, encoding: .utf8) ?? "Unable to decode data"
                DispatchQueue.main.async {
                    self.rawData = rawString
                    print(rawData)
                }
            }
        }

        dataTask.resume()
    }
}
struct APIView: View {
    @State private var rawData: String = "Loading..."

    var body: some View {
        VStack {
            Text("Raw Data")
                .font(.headline)
            ScrollView {
                Text(rawData)
                    .padding()
                    .font(.body)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            .padding()
        }
        .onAppear {
            fetchData()
        }
    }

    func fetchData() {
        let spotID = "kr25" // 실제 스팟 ID로 대체하세요
        guard let encodedSpotID = spotID.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            self.rawData = "Invalid spot ID"
            return
        }

        let headers = [
            "x-rapidapi-key": "62c4c267cdmshb924eeea03c284dp1dc19bjsn24ad9fb78cc3",
            "x-rapidapi-host": "api-windfinder-pro.p.rapidapi.com"
        ]

        let urlString = "https://api-windfinder-pro.p.rapidapi.com/spots/\(encodedSpotID)/forecasts"
        guard let url = URL(string: urlString) else {
            self.rawData = "Invalid URL"
            return
        }

        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) -> Void in
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    self.rawData = "Error: \(error.localizedDescription)"
                }
            } else if let data = data {
                let rawString = String(data: data, encoding: .utf8) ?? "Unable to decode data"
                DispatchQueue.main.async {
                    self.rawData = rawString
                    print(rawData)
                }
            }
        }

        dataTask.resume()
    }
}

#Preview {
    FindSpotView()
}
