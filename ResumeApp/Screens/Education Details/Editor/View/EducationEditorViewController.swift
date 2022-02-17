//
//  EducationEditorViewController.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import UIKit

final class EducationEditorViewController: UIViewController {
    
    // MARK: - IBOutlet Properties
    @IBOutlet private var gradeTextField: UITextField!
    
    // start date
    @IBOutlet private var startDateContainerView: UIView!
    @IBOutlet private var startDateLabel: UILabel!
    
    // end date
    @IBOutlet private var endDateContainerView: UIView!
    @IBOutlet private var endDateLabel: UILabel!
    
    // cgpa
    @IBOutlet private var cgpaTextField: UITextField!
    
    // button
    @IBOutlet private var actionButton: CustomButton!
    
    // MARK: - Properties
    private var viewModel: EducationEditorViewModel!
    private var datePickerView: DatePickerView = DatePickerView()
    var finishedWithEducationDetailItemHandler: ((Bool, EducationDetailItem) -> Void)?
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindingViewModel()
        setupTextField()
        setupLabel()
        setupButton()
        
        viewModel.viewDidLoad()
    }
    
    static func create(withDefaultValue educationDetailItem: EducationDetailItem?) -> EducationEditorViewController {
        let viewModel = EducationEditorViewModel(defaultValue: educationDetailItem)
        let vc = EducationEditorViewController(nibName: EducationEditorViewController.identifier, bundle: nil)
        vc.viewModel = viewModel
        return vc
    }
    
    // MARK: - Action
    @IBAction private func textFieldEditingChanged(_ textField: UITextField) {
        switch textField {
        case gradeTextField:
            viewModel.setGrade(text: textField.text)
        case cgpaTextField:
            viewModel.setCGPA(text: textField.text)
        default: break
        }
    }
    
    @IBAction private func startDateTapped() {
        viewModel.selectStartYearDate()
    }
    
    @IBAction private func endDateTapped() {
        viewModel.selectEndYearDate()
    }
    
    @IBAction private func actionTapped() {
        viewModel.finish()
    }
    
    // MARK: - Setup
    
    private func setup() {
        title = "Creating education detail"
        view.backgroundColor = .theme.background
    }
    
    private func setupTextField() {
        // grade
        gradeTextField.backgroundColor = .theme.background
        gradeTextField.placeholder = "X, XII, Graduation"
        
        // cgpa
        cgpaTextField.backgroundColor = .theme.background
        cgpaTextField.placeholder = "4.00"
        cgpaTextField.keyboardType = .decimalPad
    }
    
    private func setupLabel() {
        // Start Date Label
        startDateLabel.text = "Ex. Jan, 2021"
        startDateLabel.textColor = .gray.withAlphaComponent(0.5)
        startDateContainerView.backgroundColor = .theme.background
        startDateContainerView.setBorder()
        
        // End Date Label
        endDateLabel.text = "Ex. Jan, 2022"
        endDateLabel.textColor = .gray.withAlphaComponent(0.5)
        endDateContainerView.backgroundColor = .theme.background
        endDateContainerView.setBorder()
    }
    
    
    private func setupButton() {
        setupActionButton(title: "Create")
    }
    
    private func setupActionButton(title: String) {
        actionButton.setTitle(title, for: .normal)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.setTitleColor(.white, for: .disabled)
        actionButton.setBackgroundColor(.theme.accent, for: .normal)
        actionButton.setBackgroundColor(.theme.accent?.withAlphaComponent(0.3), for: .disabled)
        actionButton.setBorder()
        actionButton.isEnabled = false
    }
    
    // MARK: - Update
    func updateDateLabel(label: UILabel?, date: Date) {
        label?.text = date.asDateStringWithMMMYYYY()
        label?.textColor =  UIColor(named: "LabelColor")
    }
}

// MARK: - Binding ViewModel
extension EducationEditorViewController {
    private func bindingViewModel() {
        // output
        viewModel.shouldEnableButtonHandler = { [weak self] isEnabled in
            self?.actionButton.isEnabled = isEnabled
        }

        viewModel.didSelectStartYearDateHandler = { [weak self] startDate in
            self?.view.endEditing(true)
            self?.datePickerView.selectedDate(date: startDate)
            HUD.show(self?.datePickerView)
            
            self?.datePickerView.selectedDateHandler = { date in
                self?.updateDateLabel(label: self?.startDateLabel, date: date)
                self?.viewModel.setStartYearDate(date: date)
            }
        }
        
        viewModel.didSelectEndYearDateHandler = { [weak self] endDate in
            self?.view.endEditing(true)
            self?.datePickerView.selectedDate(date: endDate)
            HUD.show(self?.datePickerView)
            
            self?.datePickerView.selectedDateHandler = { date in
                self?.updateDateLabel(label: self?.endDateLabel, date: date)
                self?.viewModel.setEndYearDate(date: date)
            }
        }
        
        viewModel.isUpdateEducationDetailItemHandler = { [weak self] defaultValue in
            self?.title = "Updating education detail"
            self?.setupActionButton(title: "Update")
            self?.gradeTextField.text = defaultValue.grade
            self?.updateDateLabel(label: self?.startDateLabel, date: defaultValue.startYear)
            self?.updateDateLabel(label: self?.endDateLabel, date: defaultValue.endYear)
            self?.cgpaTextField.text = defaultValue.cgpa
        }
        
        viewModel.finishedWithEducationDetailItemHandler = { [weak self] isUpdate, educationDetailItem in
            self?.finishedWithEducationDetailItemHandler?(isUpdate, educationDetailItem)
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
