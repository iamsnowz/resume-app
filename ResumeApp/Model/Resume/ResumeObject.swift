//
//  ResumeModel.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 16/2/2565 BE.
//

import Foundation
import RealmSwift

class ResumeObject: Object {
    override class func primaryKey() -> String? {
        return "id"
    }
    
    @Persisted var id = ""
    @Persisted var profileImageData: Data?
    @Persisted var resumeTitle = ""
    @Persisted var firstname = ""
    @Persisted var lastname = ""
    @Persisted var mobileNumber = ""
    @Persisted var emailAddress = ""
    @Persisted var residenceAddress = ""
    @Persisted var careerObjective = ""
    @Persisted var totalYearsOfExperience = ""
}

class ResumeObjectManager {
    func createOrUpdate(resumeItem: ResumeItem) {
        delete(withId: resumeItem.id)
        let resumeObject = ResumeObject()
        resumeObject.id = resumeItem.id
        resumeObject.profileImageData = resumeItem.personalDetail.profileImageData
        resumeObject.resumeTitle = resumeItem.personalDetail.resumeTitle
        resumeObject.firstname = resumeItem.personalDetail.firstname
        resumeObject.lastname = resumeItem.personalDetail.lastname
        resumeObject.mobileNumber = resumeItem.personalDetail.mobileNumber
        resumeObject.emailAddress = resumeItem.personalDetail.emailAddress
        resumeObject.residenceAddress = resumeItem.personalDetail.residenceAddress
        resumeObject.careerObjective = resumeItem.personalDetail.careerObjective
        resumeObject.totalYearsOfExperience = resumeItem.personalDetail.totalYearsOfExperience
        RealmService.shared.saveObjects(objs: resumeObject)
    }

    func delete(withId id: String) {
        if let resume = RealmService.shared.realm.object(ofType: ResumeObject.self, forPrimaryKey: id) {
            RealmService.shared.deleteObjects(objs: resume)
        }
    }
}
