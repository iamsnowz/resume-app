//
//  ProjectDetailTableViewCell.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import UIKit

final class ProjectDetailTableViewCell: UITableViewCell, Nibbable {

    // MARK: - IBOutlet Properties
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var projectNameLabel: UILabel!
    
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
        projectNameLabel.text = "Project name..."
        projectNameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    
    }
    
    func display(item: ProjectDetailItem) {
        projectNameLabel.text = item.projectName
    }
    
}
