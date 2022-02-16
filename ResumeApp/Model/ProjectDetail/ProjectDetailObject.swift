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
class ProjectDetailSerializer {
    func serializeWith(resumeId: String, projectDetail: [ProjectDetailItem]) {
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
}
