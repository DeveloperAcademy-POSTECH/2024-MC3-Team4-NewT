import SwiftUI

struct WeatherAPITestView: View {
    @State private var rawData: String = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            } else {
                ScrollView {
                    Text(rawData)
                        .padding()
                }
            }
        }
        .onAppear(perform: fetchWeatherData)
        .navigationTitle("Weather API Test")
    }

    private func fetchWeatherData() {
        let serviceKey = "523UnnJovKnHdaJXiia1xoUoGRIAfluRCnVgANL4qigIwgxt74VuaVbqa0c4HStxpoBsOgReN0b%2BVLBNcHHDXg%3D%3D"
        let baseDate = "20240809" // Example base date
        let baseTime = "0500" // Example base time
        let nx = "55" // Example X coordinate
        let ny = "127" // Example Y coordinate
        
        let urlString = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=\(serviceKey)&numOfRows=100&pageNo=1&base_date=\(baseDate)&base_time=\(baseTime)&nx=\(nx)&ny=\(ny)&dataType=JSON"
        
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    errorMessage = error.localizedDescription
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    errorMessage = "No data received"
                }
                return
            }

            let rawResponse = String(data: data, encoding: .utf8) ?? "Unable to decode response"
            DispatchQueue.main.async {
                self.rawData = rawResponse
                print(rawResponse)
            }
        }

        task.resume()
    }
}

struct WeatherAPITestView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherAPITestView()
    }
}
