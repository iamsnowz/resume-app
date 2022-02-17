//
//  WorkSummaryEditorViewController.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import UIKit

final class WorkSummaryEditorViewController: UIViewController {
    
    // MARK: - IBOutlet Properties
    // company
    @IBOutlet private var companyTextField: UITextField!
    
    // start date
    @IBOutlet private var startDateContainerView: UIView!
    @IBOutlet private var startDateLabel: UILabel!
    
    // end date
    @IBOutlet private var endDateContainerView: UIView!
    @IBOutlet private var endDateLabel: UILabel!
    
    // button
    @IBOutlet private var actionButton: CustomButton!
    
    // MARK: - Properties
    private var viewModel: WorkSummaryEditorViewModel!
    private var datePickerView: DatePickerView = DatePickerView()
    
    var finishedWithWorkItemHandler: ((Bool, WorkSummaryItem) -> Void)?
    
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

    static func create(withDefaultValue workItem: WorkSummaryItem?) -> WorkSummaryEditorViewController {
        let viewModel = WorkSummaryEditorViewModel(defaultValue: workItem)
        let vc = WorkSummaryEditorViewController(nibName: WorkSummaryEditorViewController.identifier, bundle: nil)
        vc.viewModel = viewModel
        return vc
    }
    
    // MARK: - Action
    @IBAction private func textFieldEditingChanged(_ textField: UITextField) {
        viewModel.setCompany(text: textField.text)
    }
    
    @IBAction private func startDateTapped() {
        viewModel.selectStartDate()
    }
    
    @IBAction private func endDateTapped() {
        viewModel.selectEndDate()
    }
    
    @IBAction private func actionTapped() {
        viewModel.finish()
    }
    
    // MARK: - Setup
    private func setup() {
        title = "Creating work summary"
        view.backgroundColor = .theme.background
    }
    
    private func setupTextField() {
        // company
        companyTextField.backgroundColor = .theme.background
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
extension WorkSummaryEditorViewController {
    private func bindingViewModel() {
        // output
        viewModel.shouldEnableButtonHandler = { [weak self] isEnabled in
            self?.actionButton.isEnabled = isEnabled
        }

        viewModel.didSelectStartDateHandler = { [weak self] startDate in
            self?.view.endEditing(true)
            self?.datePickerView.selectedDate(date: startDate)
            HUD.show(self?.datePickerView)
            
            self?.datePickerView.selectedDateHandler = { date in
                self?.updateDateLabel(label: self?.startDateLabel, date: date)
                self?.viewModel.setStartDate(date: date)
            }
        }
        
        viewModel.didSelectEndDateHandler = { [weak self] endDate in
            self?.view.endEditing(true)
            self?.datePickerView.selectedDate(date: endDate)
            HUD.show(self?.datePickerView)
            
            self?.datePickerView.selectedDateHandler = { date in
                self?.updateDateLabel(label: self?.endDateLabel, date: date)
                self?.viewModel.setEndDate(date: date)
            }
        }
        
        viewModel.isUpdateWorkItemHandler = { [weak self] defaultValue in
            self?.title = "Updating work summary"
            self?.setupActionButton(title: "Update")
            self?.companyTextField.text = defaultValue.company
            self?.updateDateLabel(label: self?.startDateLabel, date: defaultValue.startDate)
            self?.updateDateLabel(label: self?.endDateLabel, date: defaultValue.endDate)
        }
        
        viewModel.finishedWithWorkItemHandler = { [weak self] isUpdate, workItem in
            self?.finishedWithWorkItemHandler?(isUpdate, workItem)
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
