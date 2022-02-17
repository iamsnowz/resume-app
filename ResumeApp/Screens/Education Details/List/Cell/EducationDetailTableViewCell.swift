//
//  EducationDetailTableViewCell.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 16/2/2565 BE.
//

import UIKit

final class EducationDetailTableViewCell: UITableViewCell, Nibbable {
    
    // MARK: - IBOutlet Properties
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var gradeLabel: UILabel!
    @IBOutlet private var passingYearLabel: UILabel!
    
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
        gradeLabel.text = "Your grade..."
        gradeLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        // ducation
        passingYearLabel.text = "Feb, 2010 - 2016"
        passingYearLabel.textColor = .theme.secondaryText
        passingYearLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    }
    
    func display(item: EducationDetailItem) {
        gradeLabel.text = item.grade
        passingYearLabel.text = "\(item.startYear.asDateStringWithMMMYYYY()) - \(item.endYear.asDateStringWithMMMYYYY())"
    }
    
}
