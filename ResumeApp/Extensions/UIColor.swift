//
//  UIColor.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 12/2/2565 BE.
//

import Foundation
import UIKit

extension UIColor {
    static let theme: ColorTheme = ColorTheme()
}

struct ColorTheme {
    
    let accent = UIColor(named: "AccentColor")
    let background = UIColor(named: "BackgroundColor")
    let green = UIColor(named: "GreenColor")
    let red = UIColor(named: "RedColor")
    let secondaryText = UIColor(named: "SecondaryTextColor")
    
}

