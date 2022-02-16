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
    func createResume(withResumeItem model: ResumeItem, completion: (() -> Void)?)
    func deleteResume(withId id: String)
    func getResumeList(completion: ((Result<Results<ResumeObject>, ServiceError>) -> Void)?)
    
}

final class ResumeService: ResumeServiceProtocol {
    var notificationToken: NotificationToken?
    
    func createResume(withResumeItem item: ResumeItem, completion: (() -> Void)?) {
        let workSerializer = WorkSummarySerializer()
        workSerializer.serializeWith(resumeId: item.id, workSummary: item.workSummary)
        
        let skillSerializer = SkillSerializer()
        skillSerializer.serializeWith(resumeId: item.id, skills: item.skills)
        
        let educationDetailSerializer = EducationDetailSerializer()
        educationDetailSerializer.serializeWith(resumeId: item.id, educationDetail: item.educationDetail)
        
        let projectDetailSerializer = ProjectDetailSerializer()
        projectDetailSerializer.serializeWith(resumeId: item.id, projectDetail: item.projectDetail)
        
        let resumeSerializer = ResumeSerializer()
        resumeSerializer.serializedObjectWith(resumeId: item.id, resumeItem: item)
  
        completion?()
    }
    
    func deleteResume(withId id: String) {
        if let resume = RealmService.shared.realm.object(ofType: ResumeObject.self, forPrimaryKey: id) {
            let workSummary = RealmService.shared.realm.objects(WorkSummaryObject.self).where { $0.resumeId == id }
            let skills = RealmService.shared.realm.objects(SkillObject.self).where { $0.resumeId == id }
            let educationDetail = RealmService.shared.realm.objects(EducationDetailObject.self).where { $0.resumeId == id }
            let projectDetail = RealmService.shared.realm.objects(ProjectDetailObject.self).where { $0.resumeId == id }
            for object in workSummary {
                RealmService.shared.deleteObjects(objs: object)
            }
            for object in skills {
                RealmService.shared.deleteObjects(objs: object)
            }
            for object in educationDetail {
                RealmService.shared.deleteObjects(objs: object)
            }
            for object in projectDetail {
                RealmService.shared.deleteObjects(objs: object)
            }
            RealmService.shared.deleteObjects(objs: resume)
        }
    }
    
    func getResumeList(completion: ((Result<Results<ResumeObject>, ServiceError>) -> Void)?) {
        let objects = RealmService.shared.realm.objects(ResumeObject.self)
        notificationToken = objects.observe { change in
            completion?(.success(objects))
        }
    }
}
