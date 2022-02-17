//
//  PopupView.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import Foundation
import UIKit

struct HUD {
    private init() { }
    static func show(_ view: UIView?) {
        if let view = view {
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(view)
        }
    }
    
    static func sheet(for viewController: UIViewController?, isViewContent: Bool = false, viewContent: ((UIAlertAction) -> Void)? = nil, editAction: ((UIAlertAction) -> Void)? = nil, deleteAction: ((UIAlertAction) -> Void)? = nil, cancelAction: ((UIAlertAction) -> Void)? = nil) {
        let alertSheet = UIAlertController(title: "What do you want to do with item?", message: nil, preferredStyle: .actionSheet)
        let edit = UIAlertAction(title: "Edit", style: .default, handler: editAction)
        let delete = UIAlertAction(title: "Delete", style: .destructive, handler: deleteAction)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelAction)
        alertSheet.addAction(cancel)
        if isViewContent {
            let viewContent = UIAlertAction(title: "View Content", style: .default, handler: viewContent)
            alertSheet.addAction(viewContent)
        }
        alertSheet.addAction(edit)
        alertSheet.addAction(delete)
        viewController?.present(alertSheet, animated: true, completion: nil)
    }
    
    
}
