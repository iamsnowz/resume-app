//
//  UITableView.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 13/2/2565 BE.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
    
    /// help to map cell for register with Nib&Identifier
    func register<T: UITableViewCell&Nibbable>(cell: T.Type) {
        register(cell.nib, forCellReuseIdentifier: cell.identifier)
    }
}
