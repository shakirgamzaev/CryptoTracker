//
//  DoubleExtension.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 7/11/24.
//

import Foundation


extension Double {
    
    /// returns a currency formatted version of a Double.
    ///
    ///given a certain double, this function will return the entire integer part, and display the first 2 decimal numbers, in US english Locale.
    ///Examples:
    ///
    ///    1) input number: 12340 : the output is 12,340.00
    ///    2) input number 74320.324141 : output formated will be $74,320.32.
    ///
    /// Also Important!!. rounding down or up will not happen, simply the decimal numbers after the second one will not be displayed. For example, if you have a double 34560.3489999, the displayed result will be $34,560.34, AND NOT $34,560.35
    func currencyFormatted() -> String {
        return self.formatted(.currency(code: "USD").precision(.fractionLength(2)).locale(.init(identifier: "en-US")))
        
    }
    
    /// similar to the currencyFormatted() function, only that the number will be displayed with 2 decimal places and a % character appended to end of the format string
    
    func percentageFormatted() -> String {
        let formatter = FloatingPointFormatStyle<Double>(locale: .init(identifier: "en-US"))
            .precision(.fractionLength(2))
            .sign(strategy: .automatic)
        return self.formatted(formatter) + "%"
    }
    
    func stringFormatted() -> String {
        return String(format: "%.2f", self)
    }
    
    func formattedWithAbbreviation() -> String {
        let sign = self < 0 ? "-" : ""
        switch self {
        case  0..<1000:
            return sign + self.currencyFormatted()
            
        case 1000..<1_000_000:
            let number = self / 1000
            return sign + number.currencyFormatted() + "K"
            
        case 1_000_000..<1_000_000_000:
            let number = self / 1_000_000
            return sign + number.currencyFormatted() + "M"
            
        case 1_000_000_000..<1_000_000_000_000:
            let number = self / 1_000_000_000
            return sign + number.currencyFormatted() + "Bn"
            
        case 1_000_000_000_000..<1_000_000_000_000_000:
            let number = self / 1_000_000_000_000
            return sign + number.currencyFormatted() + "Tr"
            
        default:
            return sign + self.currencyFormatted()
        }
    }
}
