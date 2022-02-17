//
//  DynamicHeightTableView.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 13/2/2565 BE.
//

import UIKit

class DynamicHeightTableView: UITableView {

    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != self.intrinsicContentSize {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}

