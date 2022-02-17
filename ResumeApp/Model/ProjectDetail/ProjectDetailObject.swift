//
//  ProjectDetailModel.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 16/2/2565 BE.
//

import UIKit
import RealmSwift

class ProjectDetailObject: Object {
    @Persisted var resumeId = ""
    @Persisted var projectName = ""
    @Persisted var teamSize = ""
    @Persisted var projectSummary = ""
    @Persisted var technologyUsed = ""
    @Persisted var role = ""
    
}

class ProjectDetailObjectManager {
    func createOrUpdate(resumeId: String, projectDetail: [ProjectDetailItem]) {
        delete(withId: resumeId)
        for item in projectDetail {
            let projectDetailObject = ProjectDetailObject()
            projectDetailObject.resumeId = resumeId
            projectDetailObject.projectName = item.projectName
            projectDetailObject.teamSize = item.teamSize
            projectDetailObject.projectSummary = item.projectSummary
            projectDetailObject.technologyUsed = item.technologyUsed
            projectDetailObject.role = item.role
            RealmService.shared.saveObjects(objs: projectDetailObject)
        }
    }
    
    func delete(withId id: String) {
        let projectDetailObject = RealmService.shared.realm.objects(ProjectDetailObject.self).where { $0.resumeId == id }
        for object in projectDetailObject {
            RealmService.shared.deleteObjects(objs: object)
        }
    }
}
