//
//  EmbededView.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/25/24.
//

import SwiftUI
import WebKit

struct EmbededView: View {
    var body: some View {
        WebView(url: URL(string: "https://embed.windy.com/embed.html?type=map&location=coordinates&metricRain=mm&metricTemp=°C&metricWind=km/h&zoom=5&overlay=wind&product=ecmwf&level=surface&lat=33.027&lon=129.331&detailLat=36.28&detailLon=129.419&detail=true&message=true")!)
            .frame(width: 650, height: 450)
            .edgesIgnoringSafeArea(.all)
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}


#Preview {
    EmbededView()
}
