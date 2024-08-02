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
class DateFormatterManager {
    // 싱글톤 인스턴스
    static let shared = DateFormatterManager()
    
    // private init을 통해 외부에서의 인스턴스 생성을 막음
    private init() {}
    
    // Firebase 날짜 형식
    let longDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return formatter
    }()
    
    // 짧은 날짜 형식
    let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
