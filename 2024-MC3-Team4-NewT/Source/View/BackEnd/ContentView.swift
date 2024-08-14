import SwiftUI

struct MainTestView: View {
    var body: some View {
        VStack {
            // Top Cards
            HStack(spacing: 16) {
                CardView(title: "바람", value: "0.2m")
                CardView(title: "파도", value: "0.2m", subValue: "3.3m/s")
            }
            .padding(.horizontal)
            
            // Weekly Chart
            List {
                ForEach(0..<8) { _ in
                    WeeklyRowView()
                }
            }
            .listStyle(PlainListStyle())
            
            // Bottom Tab Bar
            Spacer()
//            CustomTabBar()
        }
    }
}

struct CardView: View {
    var title: String
    var value: String
    var subValue: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            Text(value)
                .font(.largeTitle)
                .foregroundColor(.white)
            if let subValue = subValue {
                Text(subValue)
                    .font(.caption)
                    .foregroundColor(.white)
            }
        }
        .frame(width: 150, height: 100)
        .padding()
        .background(Color.blue)
        .cornerRadius(12)
    }
}

struct WeeklyRowView: View {
    var body: some View {
        HStack {
            Text("00시")
                .frame(width: 50)
            Spacer()
            Image(systemName: "wind")
            Text("3.3m/s")
                .frame(width: 80)
            Spacer()
            Image(systemName: "waveform.path.ecg")
            Text("0.2m")
                .frame(width: 80)
            Spacer()
            Image(systemName: "thermometer")
            Text("28°C")
                .frame(width: 60)
            Spacer()
            Image(systemName: "cloud.rain")
        }
        .padding(.vertical, 8)
    }
}

struct MainTestView_Previews: PreviewProvider {
    static var previews: some View {
        MainTestView()
    }
}
