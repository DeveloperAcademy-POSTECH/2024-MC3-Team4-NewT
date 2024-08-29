//
//  DateFormatterManager.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/2/24.
//
import Foundation

class DateFormatterManager {
    // 싱글톤 인스턴스
    static let shared = DateFormatterManager()
    
    // private init을 통해 외부에서의 인스턴스 생성을 막음
    private init() {}
    
    // Firebase 날짜 형식
    let longDateFormatter2: DateFormatter = {
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
    
    ///'@@시 (24시제)'로 표시해주는 Formatter
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH시"
        formatter.locale = Locale(identifier: "ko_kr")
        return formatter
    }()
    
    ///'@월 %일 &요일'로 표시해주는 Formatter
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일 EEEE"
        formatter.locale = Locale(identifier: "ko_kr")
        return formatter
    }()
    
    /// 주어진 시간 문자열을 "HH시" 형식으로 변환하는 함수
    func timeToHourFormatter(_ timeString: String) -> String {
        if let date = longDateFormatter2.date(from: timeString) {
            return timeFormatter.string(from: date)
        }
        return timeString // 파싱 실패 시 원본 문자열 반환
    }
    func dateFromString(_ timeString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: timeString)
    }
    ///'@@월 %%일 &요일'로 표시해주는 Formatter
    func date(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateFormat = "MM월 dd일 (E)"
        return formatter.string(from: date)
    }
    func dateFormatter(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일 EEEE"
        formatter.locale = Locale(identifier: "ko_kr")
        return formatter.string(from: date)
    }
    func formatDate(_ date: Date?, format: String) -> String {
        guard let date = date else {
            return ""
        }
        
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    func timeToHourFormatter(_ date: Date?) -> String {
            return formatDate(date, format: "HH'시'")
    }
    func convertDateToString(date: Date) -> String {
        return longDateFormatter2.string(from: date)
    }
}
