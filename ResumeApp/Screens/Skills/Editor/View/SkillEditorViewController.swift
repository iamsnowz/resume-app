//
//  SkillEditorViewController.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import UIKit

final class SkillEditorViewController: UIViewController {
    
    // MARK: - IBOutlet Properties
    @IBOutlet private var skillTextField: UITextField!
    @IBOutlet private var actionButton: CustomButton!
    @IBOutlet private var cancelButton: UIButton!
    
    // MARK: - Properties
    /// finish handler will callback 2 data are
    /// isUpdate status and skill name as user input
    var finishHandler: ((Bool, String) -> Void)?
    
    private var viewModel: SkillEditorViewModel!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindingViewModel()
        setupTextField()
        setupButton()
        
        viewModel.viewDidLoad()
    }

    static func create(withDefaultValue skill: String?) -> SkillEditorViewController {
        let viewModel = SkillEditorViewModel(defaultValue: skill)
        let vc = SkillEditorViewController(nibName: SkillEditorViewController.identifier, bundle: nil)
        vc.viewModel = viewModel
        return vc
    }
    
    // MARK: - Action
    @IBAction private func skillTextFieldEditingChanged(_ textField: UITextField) {
        viewModel.setSkill(text: textField.text)
    }
    
    @IBAction private func actionTapped() {
        finishHandler?(viewModel.isUpdate, viewModel.skill)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Setup
    private func setup() {
        title = "Creating skill"
        view.backgroundColor = .theme.background
    }
    
    private func setupTextField() {
        skillTextField.backgroundColor = .theme.background
        skillTextField.placeholder = "Your skill"
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
extension SkillEditorViewController {
    private func bindingViewModel() {
        
        // output
        viewModel.isUpdateSkillHandler = { [weak self] (defaultValue) in
            self?.title = "Updating skill"
            self?.setupActionButton(title: "Update")
            self?.skillTextField.text = defaultValue
        }
        
        viewModel.shouldEnableButtonHandler = { [weak self] isEnabled in
            self?.actionButton.isEnabled = isEnabled
        }
    }
}
