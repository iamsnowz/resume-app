//
//  SkillTableViewCell.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import UIKit

final class SkillTableViewCell: UITableViewCell, Nibbable {

    // MARK: - IBOutlet Properties
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var skillLabel: UILabel!
    
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
        skillLabel.text = "Skill name..."
        skillLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    // MARK: - Update
    func display(skill: String) {
        skillLabel.text = skill
    }
}
