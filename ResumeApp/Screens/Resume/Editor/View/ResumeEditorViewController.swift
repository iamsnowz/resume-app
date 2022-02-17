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
    @IBOutlet private var actionButton: CustomButton!
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
        
        viewModel.viewDidLoad()
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
        viewModel.createOrUpdate()
    }
    
    // MARK: - Setup
    private func setup() {
        title = "Creating Resume"
        view.backgroundColor = .theme.background
    }
    
    private func setupPersonalDetailsView() {
        personalDetailsView.parentViewController = self
        personalDetailsView.setDefaultValue(personalDetailItem: nil)
    }
    
    private func setupWorkSummaryListView() {
        workSummaryListView.parentViewController = self
        workSummaryListView.setDefaultValue(workSummary: nil)
    }
    
    private func setupEducationDetailsListView() {
        educationDetailsListView.parentViewController = self
        educationDetailsListView.setDefaultValue(educationDetail: nil)
    }
    
    private func setupSkillsListView() {
        skillsListView.parentViewController = self
        skillsListView.setDefaultValue(skills: nil)
    }
    
    private func setupProjectDetailsListView() {
        projectDetailsListView.parentViewController = self
        projectDetailsListView.setDefaultValue(projectDetail: nil)
    }
    
    private func setupCreateButton() {
        setupActionButton(title: "Create")
    }
    
    private func setupActionButton(title: String) {
        actionButton.backgroundColor = .theme.accent
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
extension ResumeEditorViewController {
    private func bindingViewModel() {
        // output
        viewModel.shouldEnableButtonHandler = { [weak self] isEnabled in
            self?.actionButton.isEnabled = isEnabled
        }
        
        viewModel.isUpdateResumeHandler = { [weak self] defaultValue in
            self?.title = "Updating Resume"
            self?.personalDetailsView.setDefaultValue(personalDetailItem: defaultValue.personalDetail)
            self?.skillsListView.setDefaultValue(skills: defaultValue.skills)
            self?.workSummaryListView.setDefaultValue(workSummary: defaultValue.workSummary)
            self?.educationDetailsListView.setDefaultValue(educationDetail: defaultValue.educationDetail)
            self?.projectDetailsListView.setDefaultValue(projectDetail: defaultValue.projectDetail)
            self?.setupActionButton(title: "Update")
        }
        
        viewModel.didCreateOrUpdateFinishHandler = { [weak self] in
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
