//
//  EducationDetailModel.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 16/2/2565 BE.
//

import UIKit
import RealmSwift

class EducationDetailObject: Object {
    @Persisted var resumeId = ""
    @Persisted var grade = ""
    @Persisted var startYearDate = Date()
    @Persisted var endYearDate = Date()
    @Persisted var cgpa = ""
}

class EducationDetailSerializer {
    func serializeWith(resumeId: String, educationDetail: [EducationDetailItem]) {
        for item in educationDetail {
            let educationObject = EducationDetailObject()
            educationObject.resumeId = resumeId
            educationObject.grade = item.grade
            educationObject.startYearDate = item.startYear
            educationObject.endYearDate = item.endYear
            educationObject.cgpa = item.cgpa
            RealmService.shared.saveObjects(objs: educationObject)
        }
    }
}

class EducationDetailObjectManager {
    func createOrUpdate(resumeId: String, educationDetail: [EducationDetailItem]) {
        delete(withId: resumeId)
        for item in educationDetail {
            let educationObject = EducationDetailObject()
            educationObject.resumeId = resumeId
            educationObject.grade = item.grade
            educationObject.startYearDate = item.startYear
            educationObject.endYearDate = item.endYear
            educationObject.cgpa = item.cgpa
            RealmService.shared.saveObjects(objs: educationObject)
        }
    }
    
    func delete(withId id: String) {
        let educationObject = RealmService.shared.realm.objects(EducationDetailObject.self).where { $0.resumeId == id }
        for object in educationObject {
            RealmService.shared.deleteObjects(objs: object)
        }
    }
}

