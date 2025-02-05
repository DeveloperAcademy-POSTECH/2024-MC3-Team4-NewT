//
//  WindyView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/25/24.
//

import SwiftUI

struct WindyView: View {
    @State private var lat: Double = 36.0190 // Pohang latitude
    @State private var lon: Double = 129.3435 // Pohang longitude
    @State private var apiResponse: String = "Fetching data..."
    
    var body: some View {
        VStack {
            Text("Windy API Response")
                .font(.title)
                .padding()
            
            Text("Latitude: \(lat)")
            Text("Longitude: \(lon)")
            
            TextEditor(text: $apiResponse)
                .padding()
                .border(Color.gray)
            
            Button(action: {
                fetchWeatherData(lat: lat, lon: lon)
            }) {
                Text("Fetch Weather Data")
            }
            .padding()
        }
        .padding()
    }
    
    func fetchWeatherData(lat: Double, lon: Double) {
        guard let url = URL(string: "https://api.windy.com/api/point-forecast/v2") else { return }
        
        let apiKey = "x7m179X43PHGXc0KXPSgCBzZuCsnNjKr"
        _ = Data(apiKey.utf8).base64EncodedString()
        let parameters: [String: Any] = [
            "lat": lat,
            "lon": lon,
            "model": "gfs", // global ver
            "parameters": ["wind", "windGust", "temp", "ptype"],
            "levels": ["surface"],
            "key": apiKey
        ]
        
        let waveParameters: [String: Any] = [
            "lat": lat,
            "lon": lon,
            "model": "gfsWave", // global wave model
            "parameters": ["waves"],
            "levels": ["surface"],
            "key": apiKey
        ]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []),
              let waveHttpBody = try? JSONSerialization.data(withJSONObject: waveParameters, options: []) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        
        var waveRequest = URLRequest(url: url)
        waveRequest.httpMethod = "POST"
        waveRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        waveRequest.httpBody = waveHttpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let jsonResponse = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        self.apiResponse = jsonResponse
                        print(apiResponse)
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    self.apiResponse = "Error: \(error.localizedDescription)"
                }
            }
        }.resume()
        
        URLSession.shared.dataTask(with: waveRequest) { data, response, error in
            if let data = data {
                if let jsonResponse = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        self.apiResponse += "\n\nWave Data:\n" + jsonResponse
                        print(apiResponse)
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    self.apiResponse = "Error: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

#Preview {
    WindyView()
}
