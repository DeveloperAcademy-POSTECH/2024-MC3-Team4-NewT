//
//  ModelContext.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/1/24.
//

import Foundation
import SwiftData

extension ModelContext {
    var sqliteCommand: String {
        if let url = container.configurations.first?.url.path(percentEncoded: false) {
            "sqlite3 \"\(url)\""
        } else {
            "No SQLite database found."
        }
    }
}
