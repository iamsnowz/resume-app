//
//  ProjectDetailContentTableViewCell.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 16/2/2565 BE.
//

import UIKit

final class ProjectDetailContentTableViewCell: UITableViewCell, Nibbable {

    // MARK: - IBOutlet Properties
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var projectNameLabel: UILabel!
    @IBOutlet private var teamSizeLabel: UILabel!
    @IBOutlet private var projectSummaryLabel: UILabel!
    @IBOutlet private var technologyUsedLabel: UILabel!
    @IBOutlet private var roleLabel: UILabel!
    
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
        // project name
        projectNameLabel.text = "Project name..."
        projectNameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        // teamSizeLabel
        teamSizeLabel.text = "15"
        teamSizeLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        // projectSummaryLabel
        projectSummaryLabel.text = "This project is ..."
        projectSummaryLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        // technologyUsedLabel
        technologyUsedLabel.text = "Xcode"
        technologyUsedLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        // roleLabel
        roleLabel.text = "Developer"
        roleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    func display(item: ProjectDetailItem) {
        projectNameLabel.text = item.projectName
        teamSizeLabel.text = item.teamSize
        projectSummaryLabel.text = item.projectSummary
        technologyUsedLabel.text = item.technologyUsed
        roleLabel.text = item.role
    }
}
