//
//  ResumeTableViewCell.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 16/2/2565 BE.
//

import UIKit

class ResumeTableViewCell: UITableViewCell, Nibbable {
    
    // MARK: - IBOutlet Properties
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var nameLabel: UILabel!
    
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
        // skill
        nameLabel.text = "Resume name..."
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    // MARK: - Update
    func display(resume: ResumeItem) {
        nameLabel.text = resume.resumeTitle
    }
}
