//
//  Date.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 14/2/2565 BE.
//

import UIKit

extension Date {
    
    /// Converts a Date into a String with format `MMM, YYYY`
    /// ```
    /// Convert 2022-01-31 00:00:00 to "Jan, 2022"
    /// ```
    func asDateStringWithMMMYYYY() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM, YYYY"
        return dateFormatter.string(from: self)
    }

}
