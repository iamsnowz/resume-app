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
    func deleteResume(withId id: String)
    func getResumeList(completion: ((Result<Results<ResumeObject>, ServiceError>) -> Void)?)
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
    
    func deleteResume(withId id: String) {
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
    }
    
    func getResumeList(completion: ((Result<Results<ResumeObject>, ServiceError>) -> Void)?) {
        notificationToken?.invalidate()
        let objects = RealmService.shared.realm.objects(ResumeObject.self)
        notificationToken = objects.observe { change in
            completion?(.success(objects))
        }
    }
}
