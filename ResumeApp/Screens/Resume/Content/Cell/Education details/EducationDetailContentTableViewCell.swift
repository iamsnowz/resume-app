//
//  EducationDetailContentTableViewCell.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 16/2/2565 BE.
//

import UIKit

final class EducationDetailContentTableViewCell: UITableViewCell, Nibbable {

    // MARK: - IBOutlet Properties
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var gradeLabel: UILabel!
    @IBOutlet private var passingYearLabel: UILabel!
    @IBOutlet private var cgpaLabel: UILabel!
    
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
        // grade
        gradeLabel.text = "Company name..."
        gradeLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        // passing year
        passingYearLabel.text = "Feb, 2020 - Present"
        passingYearLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        // CGPA
        cgpaLabel.text = "CGPA: 5"
        cgpaLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    func display(item: EducationDetailItem) {
        gradeLabel.text = "Class: \(item.grade)"
        passingYearLabel.text = "Passing year: \(item.startYear.asDateStringWithMMMYYYY()) - \(item.endYear.asDateStringWithMMMYYYY())"
        cgpaLabel.text = "CGPA: \(item.cgpa)"
    }
}
