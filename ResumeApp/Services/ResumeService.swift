//
//  ResumeService.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 16/2/2565 BE.
//

import UIKit
import RealmSwift

enum ServiceError: Error {
    case notFoundData
}
protocol ResumeServiceProtocol {
    func createOrUpdate(withResumeItem model: ResumeItem, completion: (() -> Void)?)
    func deleteResume(withId id: String, _ completion: (() -> Void)?)
    func observe(completion: ((Result<[ResumeItem], ServiceError>) -> Void)?)
}

final class ResumeService: ResumeServiceProtocol {
    var notificationToken: NotificationToken?
    func createOrUpdate(withResumeItem model: ResumeItem, completion: (() -> Void)?) {
        let workManager = WorkSummaryObjectManager()
        workManager.createOrUpdate(resumeId: model.id, workSummary: model.workSummary)
        
        let skillManager = SkillObjectManager()
        skillManager.createOrUpdate(resumeId: model.id, skills: model.skills)
        
        let educationDetailManager = EducationDetailObjectManager()
        educationDetailManager.createOrUpdate(resumeId: model.id, educationDetail: model.educationDetail)
        
        let projectDetailManager = ProjectDetailObjectManager()
        projectDetailManager.createOrUpdate(resumeId: model.id, projectDetail: model.projectDetail)
        
        let resumeManager = ResumeObjectManager()
        resumeManager.createOrUpdate(resumeItem: model)
        completion?()
    }
    
    func deleteResume(withId id: String, _ completion: (() -> Void)?) {
        let workManager = WorkSummaryObjectManager()
        let skillManager = SkillObjectManager()
        let educationDetailManager = EducationDetailObjectManager()
        let projectDetailManager = ProjectDetailObjectManager()
        let resumeManager = ResumeObjectManager()
        
        workManager.delete(withId: id)
        skillManager.delete(withId: id)
        educationDetailManager.delete(withId: id)
        projectDetailManager.delete(withId: id)
        resumeManager.delete(withId: id)
        completion?()
    }
    
    func observe(completion: ((Result<[ResumeItem], ServiceError>) -> Void)?) {
        notificationToken?.invalidate()
        let objects = RealmService.shared.realm.objects(ResumeObject.self)
        notificationToken = objects.observe { [weak self] change in
            guard let strongSelf = self else { return }
            if objects.isEmpty {
                completion?(.failure(.notFoundData))
            } else {
                let result = strongSelf.prepareData(results: objects)
                completion?(.success(result))
            }
        }
    }
    
    private func prepareData(results: Results<ResumeObject>) -> [ResumeItem] {
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
        return resumeList
    }
}
