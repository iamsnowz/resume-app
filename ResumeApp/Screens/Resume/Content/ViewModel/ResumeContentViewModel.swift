//
//  ResumeContentViewModel.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 16/2/2565 BE.
//

import UIKit

enum ResumeContentSection: Int, CaseIterable {
    case workSummary
    case skill
    case educationDetail
    case projectDetail
    
    var title: String {
        switch self {
        case .workSummary:
            return "Work Summary"
        case .skill:
            return "Skills"
        case .educationDetail:
            return "Education details"
        case .projectDetail:
            return "Project details"
        }
    }
}

protocol ResumeContentViewModelOutput {
    var displayResumeHandler: ((ResumeItem) -> Void)? { get }
    
    func numberOfSection() -> Int
    func numberOfRow(in section: Int) -> Int
    func titleForHeader(in section: Int) -> String
    func getResumeContentSection(in section: Int) -> ResumeContentSection
    
    func workSummaryItem(at indexPath: IndexPath) -> WorkSummaryItem
    func skill(at indexPath: IndexPath) -> String
    func educationDetail(at indexPath: IndexPath) -> EducationDetailItem
    func projectDetail(at indexPath: IndexPath) -> ProjectDetailItem
}

protocol ResumeContentViewModelInput {
    func viewDidLoad()
}

final class ResumeContentViewModel: ResumeContentViewModelInput, ResumeContentViewModelOutput {
    
    private let resume: ResumeItem
    
    init(resume: ResumeItem) {
        self.resume = resume
    }
    
    // MARK: - Output
    var displayResumeHandler: ((ResumeItem) -> Void)?
    
    func numberOfSection() -> Int {
        return ResumeContentSection.allCases.count
    }
    
    func numberOfRow(in section: Int) -> Int {
        switch getResumeContentSection(in: section) {
        case .workSummary:
            return resume.workSummary.count
        case .skill:
            return resume.skills.count
        case .educationDetail:
            return resume.educationDetail.count
        case .projectDetail:
            return resume.projectDetail.count
        }
    }
    
    func titleForHeader(in section: Int) -> String {
        let section = getResumeContentSection(in: section)
        return section.title
    }
    
    func getResumeContentSection(in section: Int) -> ResumeContentSection {
        return ResumeContentSection(rawValue: section) ?? .workSummary
    }
    
    
    // get work summary
    func workSummaryItem(at indexPath: IndexPath) -> WorkSummaryItem {
        return resume.workSummary[indexPath.row]
    }
    
    // get skill
    func skill(at indexPath: IndexPath) -> String {
        return resume.skills[indexPath.row]
    }
    
    // education
    func educationDetail(at indexPath: IndexPath) -> EducationDetailItem {
        return resume.educationDetail[indexPath.row]
    }
    
    // project detail
    func projectDetail(at indexPath: IndexPath) -> ProjectDetailItem {
        return resume.projectDetail[indexPath.row]
    }
    
    // MARK: - Input
    func viewDidLoad() {
        displayResumeHandler?(resume)
    }
}
