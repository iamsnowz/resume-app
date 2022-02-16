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

class ResumeSerializer {
    
    func serializedObjectWith(resumeId: String, resumeItem: ResumeItem) {
        let resumeObject = ResumeObject()
        resumeObject.id = resumeId
        resumeObject.profileImageData = resumeItem.profileImageData
        resumeObject.resumeTitle = resumeItem.resumeTitle
        resumeObject.firstname = resumeItem.firstname
        resumeObject.lastname = resumeItem.lastname
        resumeObject.mobileNumber = resumeItem.mobileNumber
        resumeObject.emailAddress = resumeItem.emailAddress
        resumeObject.residenceAddress = resumeItem.residenceAddress
        resumeObject.careerObjective = resumeItem.careerObjective
        resumeObject.totalYearsOfExperience = resumeItem.totalYearsOfExperience
        RealmService.shared.saveObjects(objs: resumeObject)
    }
}


