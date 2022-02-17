//
//  UIView.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 13/2/2565 BE.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
    
    func setBorder(_ color: UIColor? = nil) {
        layer.borderColor = color == nil ? UIColor.lightGray.withAlphaComponent(0.25).cgColor : color?.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 4.0
    }
}



