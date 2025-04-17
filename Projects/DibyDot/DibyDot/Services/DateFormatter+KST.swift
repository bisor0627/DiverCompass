import Foundation

extension DateFormatter {
    /// POSIX 로케일(en_US_POSIX)은 날짜와 시간의 파싱 및 포맷팅에서 일관성을 보장하여,
    /// 이는 특히 서버와의 데이터 교환이나 특정 형식의 날짜 문자열을 다룰 때 유용함.
    /// 반면, Locale(identifier: "ko_KR")는 한국 로케일에 맞는 형식으로 동작하지만,
    /// 시스템 설정이나 사용자 환경에 따라 결과가 달라질 수 있음
    static let kst: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return formatter
    }()
    
    static func kstDate(from string: String) -> Date {
        guard let date = kst.date(from: string) else {
            fatalError("유효하지 않은 날짜 형식: \(string). 예상 형식: yyyy-MM-dd")
        }
        return date
    }
}