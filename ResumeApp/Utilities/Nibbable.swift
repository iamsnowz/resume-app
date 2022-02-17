//
//  Nibbable.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 13/2/2565 BE.
//
import UIKit

protocol Nibbable: AnyObject {
    static var nib: UINib { get }
}

extension Nibbable {
    
    static var nib: UINib {
        guard let nibName = NSStringFromClass(Self.self).components(separatedBy: ".").last else {
            fatalError("Class name not found")
        }
        return UINib(nibName: nibName, bundle: nil)
    }
    
}
