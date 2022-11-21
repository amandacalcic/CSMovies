//
//  String+Extension.swift
//  CSMovies
//
//  Created by Amanda Calcic on 21/11/22.
//

import Foundation

public extension String {
    func convertToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        guard let date = dateFormatter.date(from: self) else { return Date() }
        
        return date
    }
    
    func convertDateToBRFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterBr = DateFormatter()
        dateFormatterBr.dateFormat = "dd/MM/yyyy"
        
        guard let date = dateFormatter.date(from: self) else { return "" }
        
        return dateFormatterBr.string(from: date)
    }
}
