//
//  ResumeListViewModel.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 16/2/2565 BE.
//

import UIKit
import RealmSwift

protocol ResumeListViewModelOutput {
    var listeningToTableViewReload: (() -> Void)? { get }
    var didSelectResumeHandler: ((IndexPath, ResumeItem) -> Void)? { get }
    
    func numberOfItem(in section: Int) -> Int
    func resume(at indexPath: IndexPath) -> ResumeItem
}

protocol ResumeListViewModelInput {
    func fetchResumeList()
    
    func selectedResume(at indexPath: IndexPath)
    func delete(at indexPath: IndexPath)
}

final class ResumeListViewModel: ResumeListViewModelInput, ResumeListViewModelOutput {
    private var resumeList: [ResumeItem] = [] {
        didSet {
            listeningToTableViewReload?()
        }
    }
    private let service: ResumeServiceProtocol
    
    init(service: ResumeServiceProtocol) {
        self.service = service
    }
    
    // MARK: - Output
    var listeningToTableViewReload: (() -> Void)?
    var didSelectResumeHandler: ((IndexPath, ResumeItem) -> Void)?
    
    func numberOfItem(in section: Int) -> Int {
        return resumeList.count
    }
    
    func resume(at indexPath: IndexPath) -> ResumeItem {
        return resumeList[indexPath.row]
    }
    
    // MARK: - Input
    func selectedResume(at indexPath: IndexPath) {
        didSelectResumeHandler?(indexPath, resume(at: indexPath))
    }
    
    func delete(at indexPath: IndexPath) {
        let id = resume(at: indexPath).id
        service.deleteResume(withId: id)
    }
    
    func fetchResumeList() {
        service.getResumeList { [weak self] result in
            switch result {
            case .success(let results):
                self?.prepareData(results: results)
            case .failure(let error):
                break
            }
        }
    }
    
    private func prepareData(results: Results<ResumeObject>) {
        var resumeList: [ResumeItem] = []
        for resumeObject in results {
            let personalDetail = PersonalDetailItem(profileImageData: resumeObject.profileImageData,
                                                    resumeTitle: resumeObject.resumeTitle,
                                                    firstname: resumeObject.firstname,
                                                    lastname: resumeObject.lastname,
                                                    mobileNumber: resumeObject.mobileNumber,
                                                    emailAddress: resumeObject.emailAddress,
                                                    residenceAddress: resumeObject.residenceAddress,
                                                    careerObjective: resumeObject.careerObjective,
                                                    totalYearsOfExperience: resumeObject.totalYearsOfExperience)
            let workSummary: [WorkSummaryItem] = RealmService.shared.realm.objects(WorkSummaryObject.self).where {
                $0.resumeId == resumeObject.id
            }.map { WorkSummaryItem(company: $0.companyName, startDate: $0.startDate, endDate: $0.endDate) }
            
            let skills: [String] = RealmService.shared.realm.objects(SkillObject.self).where {
                $0.resumeId == resumeObject.id
            }.map { $0.name }
            
            let educationDetails: [EducationDetailItem] = RealmService.shared.realm.objects(EducationDetailObject.self).where {
                $0.resumeId == resumeObject.id
            }.map { EducationDetailItem(grade: $0.grade, startYear: $0.startYearDate, endYear: $0.endYearDate, cgpa: $0.cgpa) }
            
            let projectDetails: [ProjectDetailItem] = RealmService.shared.realm.objects(ProjectDetailObject.self).where {
                $0.resumeId == resumeObject.id
            }.map { ProjectDetailItem(projectName: $0.projectName, teamSize: $0.teamSize, projectSummary: $0.projectSummary, technologyUsed: $0.technologyUsed, role: $0.role) }
            
            resumeList.append(ResumeItem(id: resumeObject.id,
                                         personalDetail: personalDetail,
                                         workSummary: workSummary,
                                         skills: skills,
                                         educationDetail: educationDetails,
                                         projectDetail: projectDetails))
        }
        self.resumeList = resumeList
    }
}

