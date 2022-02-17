//
//  WorkSummaryContentTableViewCell.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 16/2/2565 BE.
//

import UIKit

final class WorkSummaryContentTableViewCell: UITableViewCell, Nibbable{

    // MARK: - IBOutlet Properties
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var companyLabel: UILabel!
    @IBOutlet private var durationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        setupLabel()
    }
    
    // MARK: - Setup
    private func setup() {
        selectionStyle = .none
        contentView.backgroundColor = .theme.background
        
        containerView.backgroundColor = .theme.background
        containerView.setBorder()
    }
    
    private func setupLabel() {
        // company
        companyLabel.text = "Company name..."
        companyLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        // ducation
        durationLabel.text = "Feb, 2020 - Present"
        durationLabel.textColor = .theme.secondaryText
        durationLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    }
    
    func display(item: WorkSummaryItem) {
        companyLabel.text = item.company
        durationLabel.text = "\(item.startDate.asDateStringWithMMMYYYY()) - \(item.endDate.asDateStringWithMMMYYYY())"
    }

}
