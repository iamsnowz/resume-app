//
//  ResumeEditorViewController.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import UIKit

final class ResumeEditorViewController: UIViewController {

    // MARK: - IBOutlet Properties
    // Personal details
    @IBOutlet private var personalDetailsView: PersonalDetailsView!
    // Work summary
    @IBOutlet private var workSummaryListView: WorkSummaryListView!
    // Skills
    @IBOutlet private var skillsListView: SkillsListView!
    // Education Details
    @IBOutlet private var educationDetailsListView: EducationDetailsListView!
    // Project Details
    @IBOutlet private var projectDetailsListView: ProjectDetailsListView!
    // Button
    @IBOutlet private var createButton: CustomButton!
    // MARK: - Properties
    private var viewModel: ResumeEditorViewModel!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupPersonalDetailsView()
        setupWorkSummaryListView()
        setupSkillsListView()
        setupEducationDetailsListView()
        setupProjectDetailsListView()
        setupCreateButton()
        bindingViewModel()
    }

    static func create(withDefaultValue resume: ResumeItem?) -> ResumeEditorViewController {
        let service = ResumeService()
        let viewModel = ResumeEditorViewModel(defaultValue: resume, service: service)
        let vc = ResumeEditorViewController(nibName: ResumeEditorViewController.identifier, bundle: nil)
        vc.viewModel = viewModel
        return vc
    }
    
    // MARK: - Action
    @IBAction private func createTapped() {
        viewModel.create()
    }
    
    // MARK: - Setup
    private func setup() {
        title = "Creating Resume"
        view.backgroundColor = .theme.background
    }
    
    private func setupPersonalDetailsView() {
        personalDetailsView.parentViewController = self
    }
    
    private func setupWorkSummaryListView() {
        workSummaryListView.parentViewController = self
    }
    
    private func setupEducationDetailsListView() {
        educationDetailsListView.parentViewController = self
    }
    
    private func setupSkillsListView() {
        skillsListView.parentViewController = self
    }
    
    private func setupProjectDetailsListView() {
        projectDetailsListView.parentViewController = self
    }
    
    private func setupCreateButton() {
        createButton.backgroundColor = .theme.accent
        createButton.setTitle("Create", for: .normal)
        createButton.setTitleColor(.white, for: .normal)
        createButton.setTitleColor(.white, for: .disabled)
        createButton.setBackgroundColor(.theme.accent, for: .normal)
        createButton.setBackgroundColor(.theme.accent?.withAlphaComponent(0.3), for: .disabled)
        createButton.setBorder()
        createButton.isEnabled = false
    }
    
}

// MARK: - Binding ViewModel
extension ResumeEditorViewController {
    private func bindingViewModel() {
        // output
        viewModel.shouldEnableButtonHandler = { [weak self] isEnabled in
            self?.createButton.isEnabled = isEnabled
        }
        
        viewModel.didCreateFinishHandler = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        // personal detail
        personalDetailsView.didUserFinishInputData = { [weak self] personalDetail in
            self?.viewModel.setPersonalDetail(personanDetail: personalDetail)
        }
        // work summary
        workSummaryListView.didUpdateWorkItemsListHandler = { [weak self] list in
            self?.viewModel.setWorkSummary(workSummary: list)
        }
        // skills
        skillsListView.didUpdateSkillsListHandler = { [weak self] list in
            self?.viewModel.setSkills(skills: list)
        }
        
        // education details
        educationDetailsListView.didUpdateEducationDetailItemsListHandler = { [weak self] list in
            self?.viewModel.setEducationDetails(educationDetails: list)
        }
        // project details
        projectDetailsListView.didUpdateProjectDetailItemsListHandler = { [weak self] list in
            self?.viewModel.setProjectDetails(projectDetails: list)
        }
    }
}
