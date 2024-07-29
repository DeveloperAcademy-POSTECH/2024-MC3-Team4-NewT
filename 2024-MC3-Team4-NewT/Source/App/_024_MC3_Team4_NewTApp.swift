//
//  _024_MC3_Team4_NewTApp.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 7/21/24.
//

import SwiftUI
import SwiftData

@main
struct _024_MC3_Team4_NewTApp: App {
    var body: some Scene {
        var sharedModelContainer: ModelContainer = {
            let schema = Schema([
                ChartRow.self,
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
        
        WindowGroup {
            NavigationStack{
                TestView()
                    .modelContainer(sharedModelContainer)
            }
        }
    }
}
