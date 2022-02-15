//
//  DatePickerView.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 13/2/2565 BE.
//

import UIKit

final class DatePickerView: UIView, NibFileOwnerLoadable {
    
    // MARK: - IBOutlet Properties
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var datePicker: UIDatePicker!
    @IBOutlet private var doneButton: UIButton!
    @IBOutlet private var cancelButton: UIButton!
    
    // MARK: - Properties
    var contentView: UIView!
    var cancelHandler: (() -> Void)?
    var selectedDateHandler: ((Date) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        loadNibContent()
        setup()
        setupContainerView()
        setupDatePicker()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
        setup()
        setupContainerView()
        setupDatePicker()
        setupButton()
    }
    
    // MARK: - Action
    @IBAction private func selectedDateTapped() {
    }
    
    @IBAction private func doneTapped() {
        selectedDateHandler?(datePicker.date)
        removeFromSuperview()
    }
    
    @IBAction private func cancelTapped() {
        cancelHandler?()
        removeFromSuperview()
    }
    
    // MARK: - Setup
    private func setup() {
        overrideUserInterfaceStyle = .light
        contentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    private func setupContainerView() {
        containerView.backgroundColor = .white
        containerView.setBorder()
    }
    
    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
    }
    
    private func setupButton() {
        // done button
        doneButton.backgroundColor = .theme.accent
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.setBorder()
        
        // cancel button
        cancelButton.setBorder(.theme.accent)
        cancelButton.setTitleColor(.theme.accent, for: .normal)
    }
    
    // MARK: - Update
    func selectedDate(date: Date) {
        datePicker.date = date
    }
}
