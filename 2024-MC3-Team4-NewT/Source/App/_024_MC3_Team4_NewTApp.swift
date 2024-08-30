//
//  _024_MC3_Team4_NewTApp.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/21/24.
//
import SwiftUI
import SwiftData
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct MC3_Team4_NewTApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            OnboardingView()
        }
        .modelContainer(for: [
            DailySurfingValues.self,
            OldSurfingValues.self,
            OldChartRow.self,
            OldDailyWeather.self,
            OldSurfingRecordOne.self,
            OldStatistics.self
        ])
    }
}

// Debug extension
extension ModelContext {
    var sqliteCommand: String {
        if let url = container.configurations.first?.url.path(percentEncoded: false) {
            return "sqlite3 \"\(url)\""
        } else {
            return "No SQLite database found."
        }
    }
}
