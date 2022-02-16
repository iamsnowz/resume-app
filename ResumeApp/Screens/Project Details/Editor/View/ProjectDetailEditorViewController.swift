//
//  ProjectDetailEditorViewController.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import UIKit

final class ProjectDetailEditorViewController: UIViewController {

    // MARK: - IBOutlet Properties
    @IBOutlet private var projectNameTextField: UITextField!
    @IBOutlet private var teamSizeTextField: UITextField!
    @IBOutlet private var projectSummaryTextView: UITextView!
    @IBOutlet private var technologyUsedTextView: UITextView!
    @IBOutlet private var roleTextField: UITextField!
    @IBOutlet private var actionButton: CustomButton!
    
    // MARK: - Properties
    private var viewModel: ProjectDetailEditorViewModel!
    var finishedWithProjectDetailItemHandler: ((Bool, ProjectDetailItem) -> Void)?
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindingViewModel()
        setupTextField()
        setupTextView()
        setupButton()
        
        viewModel.viewDidLoad()
    }
    
    static func create(withDefaultValue projectDetailItem: ProjectDetailItem?) -> ProjectDetailEditorViewController {
        let viewModel = ProjectDetailEditorViewModel(defaultValue: projectDetailItem)
        let vc = ProjectDetailEditorViewController(nibName: ProjectDetailEditorViewController.identifier, bundle: nil)
        vc.viewModel = viewModel
        return vc
    }
    
    // MARK: - Action
    @IBAction private func textFieldEditingChanged(_ textField: UITextField) {
        switch textField {
        case projectNameTextField:
            viewModel.setProjectName(text: textField.text)
        case teamSizeTextField:
            viewModel.setTeamSize(text: textField.text)
        case roleTextField:
            viewModel.setRole(text: textField.text)
        default:
            break
        }
    }
    
    @IBAction private func actionTapped() {
        viewModel.finish()
    }
    
    // MARK: - Setup
    private func setup() {
        title = "Creating project detail"
        view.backgroundColor = .theme.background
    }
    
    private func setupTextField() {
        // project name
        projectNameTextField.placeholder = "Project name..."
        projectNameTextField.autocorrectionType = .no
        projectNameTextField.backgroundColor = .theme.background
        projectNameTextField.tag = 0
        
        // team size
        teamSizeTextField.placeholder = "Team size"
        teamSizeTextField.autocorrectionType = .no
        teamSizeTextField.backgroundColor = .theme.background
        teamSizeTextField.keyboardType = .numberPad
        teamSizeTextField.tag = 1
        
        // mobile number
        roleTextField.placeholder = "Role..."
        roleTextField.autocorrectionType = .no
        roleTextField.backgroundColor = .theme.background
        roleTextField.tag = 2
    }
    
    private func setupTextView() {
        // project summary
        projectSummaryTextView.delegate = self
        projectSummaryTextView.autocorrectionType = .no
        projectSummaryTextView.backgroundColor = .theme.background
        projectSummaryTextView.setPadding()
        projectSummaryTextView.setBorder()
        
        // technology usde
        technologyUsedTextView.delegate = self
        technologyUsedTextView.autocorrectionType = .no
        technologyUsedTextView.backgroundColor = .theme.background
        technologyUsedTextView.setPadding()
        technologyUsedTextView.setBorder()
    }
    
    private func setupButton() {
        // action button
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
}

// MARK: - Binding ViewModel
extension ProjectDetailEditorViewController {
    private func bindingViewModel() {
        // output
        viewModel.shouldEnableButtonHandler = { [weak self] isEnabled in
            self?.actionButton.isEnabled = isEnabled
        }
        
        viewModel.isUpdateProjectDetailHandler = { [weak self] defaultValue in
            self?.title = "Updating project detail"
            self?.setupActionButton(title: "Update")
            self?.projectNameTextField.text = defaultValue.projectName
            self?.teamSizeTextField.text = defaultValue.teamSize
            self?.projectSummaryTextView.text = defaultValue.projectSummary
            self?.technologyUsedTextView.text = defaultValue.technologyUsed
            self?.roleTextField.text = defaultValue.role
        }
        
        viewModel.finishedWithProjectDetailItemHandler = { [weak self] isUpdate, projectDetailItem in
            self?.finishedWithProjectDetailItemHandler?(isUpdate, projectDetailItem)
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - ProjectDetailEditorViewController
extension ProjectDetailEditorViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        switch textView {
        case projectSummaryTextView:
            viewModel.setProjectSummary(text: textView.text)
        case technologyUsedTextView:
            viewModel.setTechnologyUsed(text: textView.text)
        default:
            break
        }
    }
}
