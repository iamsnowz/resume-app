//
//  ResumeEditorViewModel.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 16/2/2565 BE.
//

import UIKit

protocol ResumeEditorViewModelOutput {
    var shouldEnableButtonHandler: ((Bool) -> Void)? { get }
    var didCreateFinishHandler: (() -> Void)? { get }
}

protocol ResumeEditorViewModelInput {
    func create()
    func setPersonalDetail(personanDetail: PersonalDetailItem)
    func setWorkSummary(workSummary: [WorkSummaryItem])
    func setSkills(skills: [String])
    func setEducationDetails(educationDetails: [EducationDetailItem])
    func setProjectDetails(projectDetails: [ProjectDetailItem])
}

final class ResumeEditorViewModel: ResumeEditorViewModelInput, ResumeEditorViewModelOutput {
    private let defaultValue: ResumeItem?
    private let service: ResumeService
    init(defaultValue: ResumeItem?, service: ResumeService) {
        self.defaultValue = defaultValue
        self.service = service
    }
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
    var didCreateFinishHandler: (() -> Void)?
    
    // MARK: - Input
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
    
    func create() {
        guard let personalDetail = personalDetail else {
            return
        }

        let uuid = UUID().uuidString
        let resumeItem = ResumeItem(id: uuid,
                                    profileImageData: personalDetail.profileImageData,
                                    resumeTitle: personalDetail.resumeTitle,
                                    firstname: personalDetail.firstname,
                                    lastname: personalDetail.lastname,
                                    mobileNumber: personalDetail.mobileNumber,
                                    emailAddress: personalDetail.emailAddress,
                                    residenceAddress: personalDetail.residenceAddress,
                                    careerObjective: personalDetail.careerObject,
                                    totalYearsOfExperience: personalDetail.totalYearsOfExperience,
                                    workSummary: workSummaryItemsList,
                                    skills: skillsList,
                                    educationDetail: educationDetailItemsList,
                                    projectDetail: projectDetailItemsList)
        
        service.createResume(withResumeItem: resumeItem) { [weak self] in
            self?.didCreateFinishHandler?()
        }
    }
}
