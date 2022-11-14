//
//  DateFormatterUtil.swift
//  CSMovies
//
//  Created by Amanda Calcic on 14/11/22.
//

import Foundation

public class DateFormatterUtil {
    public func convertDateFormat(stringDate: String) -> String {
        let date = formatStringToDate(dateString: stringDate)
        let newFormat = formatDateToString(date: date)
        
        return newFormat
    }
    
    private func formatStringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        return date
    }
    
    private func formatDateToString(date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let dateString = dateFormatter.string(from: date!)
        return dateString
    }
}
