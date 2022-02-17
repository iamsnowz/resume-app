//
//  ResumeEditorViewModel.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 16/2/2565 BE.
//

import UIKit

protocol ResumeEditorViewModelOutput {
    var shouldEnableButtonHandler: ((Bool) -> Void)? { get }
    var isUpdateResumeHandler: ((ResumeItem) -> Void)? { get}
    var didCreateOrUpdateFinishHandler: (() -> Void)? { get }
}

protocol ResumeEditorViewModelInput {
    func viewDidLoad()
    func createOrUpdate()
    func setPersonalDetail(personanDetail: PersonalDetailItem)
    func setWorkSummary(workSummary: [WorkSummaryItem])
    func setSkills(skills: [String])
    func setEducationDetails(educationDetails: [EducationDetailItem])
    func setProjectDetails(projectDetails: [ProjectDetailItem])
}

final class ResumeEditorViewModel: ResumeEditorViewModelInput, ResumeEditorViewModelOutput {
    
    private let defaultValue: ResumeItem?
    private let service: ResumeServiceProtocol
    
    init(defaultValue: ResumeItem?, service: ResumeServiceProtocol) {
        self.defaultValue = defaultValue
        self.service = service
    }
    
    private var isUpdate: Bool = false
    
    private var personalDetail: PersonalDetailItem? {
        didSet {
            evaluateData()
        }
    }
    private var workSummaryItemsList: [WorkSummaryItem] = [] {
        didSet {
            evaluateData()
        }
    }
    
    private var skillsList: [String] = [] {
        didSet {
            evaluateData()
        }
    }
    
    private var educationDetailItemsList: [EducationDetailItem] = [] {
        didSet {
            evaluateData()
        }
    }
    
    private var projectDetailItemsList: [ProjectDetailItem] = [] {
        didSet {
            evaluateData()
        }
    }
    
    private func evaluateData() {
        let isEnabled = personalDetail != nil && !workSummaryItemsList.isEmpty && !skillsList.isEmpty && !educationDetailItemsList.isEmpty && !projectDetailItemsList.isEmpty
        shouldEnableButtonHandler?(isEnabled)
    }
    
    // MARK: - Output
    var shouldEnableButtonHandler: ((Bool) -> Void)?
    var isUpdateResumeHandler: ((ResumeItem) -> Void)?
    var didCreateOrUpdateFinishHandler: (() -> Void)?
    
    // MARK: - Input
    func viewDidLoad() {
        isUpdate = defaultValue != nil
        if isUpdate, let defaultValue = defaultValue {
            setPersonalDetail(personanDetail: defaultValue.personalDetail)
            setWorkSummary(workSummary: defaultValue.workSummary)
            setSkills(skills: defaultValue.skills)
            setEducationDetails(educationDetails: defaultValue.educationDetail)
            setProjectDetails(projectDetails: defaultValue.projectDetail)
            isUpdateResumeHandler?(defaultValue)
        }
    }
    
    func setPersonalDetail(personanDetail: PersonalDetailItem) {
        self.personalDetail = personanDetail
    }
    
    func setWorkSummary(workSummary: [WorkSummaryItem]) {
        if !workSummary.isEmpty {
            workSummaryItemsList = workSummary
        }
    }
    
    func setSkills(skills: [String]) {
        if !skills.isEmpty {
            skillsList = skills
        }
    }
    
    func setEducationDetails(educationDetails: [EducationDetailItem]) {
        if !educationDetails.isEmpty {
            educationDetailItemsList = educationDetails
        }
    }
    
    func setProjectDetails(projectDetails: [ProjectDetailItem]) {
        if !projectDetails.isEmpty {
            projectDetailItemsList = projectDetails
        }
    }
    
    func createOrUpdate() {
        guard let personalDetail = personalDetail else {
            return
        }
        if isUpdate, let defaultValue = defaultValue {
            let resumeItem = ResumeItem(id: defaultValue.id,
                                        personalDetail: personalDetail,
                                        workSummary: workSummaryItemsList,
                                        skills: skillsList,
                                        educationDetail: educationDetailItemsList,
                                        projectDetail: projectDetailItemsList)
            service.createOrUpdate(withResumeItem: resumeItem) { [weak self] in
                self?.didCreateOrUpdateFinishHandler?()
            }
        } else {
            let uuid = UUID().uuidString
            let resumeItem = ResumeItem(id: uuid,
                                        personalDetail: personalDetail,
                                        workSummary: workSummaryItemsList,
                                        skills: skillsList,
                                        educationDetail: educationDetailItemsList,
                                        projectDetail: projectDetailItemsList)
            service.createOrUpdate(withResumeItem: resumeItem) { [weak self] in
                self?.didCreateOrUpdateFinishHandler?()
            }
        }
    }
    
}
