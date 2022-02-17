//
//  AddNewContentTableViewCell.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import UIKit

enum AddNewContentTableViewCellDisplayType: String {
    case workSummary
    case skill
    case educationDetail
    case projectDetail
}

final class AddNewContentTableViewCell: UITableViewCell, Nibbable {
    
    @IBOutlet private var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        selectionStyle = .none
        contentView.backgroundColor = .theme.background
    }
    
    func display(for type: AddNewContentTableViewCellDisplayType) {
        switch type {
        case .workSummary:
            titleLabel.text = "+ Add one more work history"
        case .skill:
            titleLabel.text = "+ Add one more skill"
        case .educationDetail:
            titleLabel.text = "+ Add one more education detail"
        case .projectDetail:
            titleLabel.text = "+ Add one more project detail"
        }
    }
}
