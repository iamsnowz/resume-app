//
//  SkillModel.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 16/2/2565 BE.
//

import Foundation
import RealmSwift

class SkillObject: Object {
    @Persisted var resumeId = ""
    @Persisted var name = ""
}

class SkillObjectManager {
    func createOrUpdate(resumeId: String, skills: [String]) {
        delete(withId: resumeId)
        for item in skills {
            let skillObject = SkillObject()
            skillObject.resumeId = resumeId
            skillObject.name = item
            RealmService.shared.saveObjects(objs: skillObject)
        }
    }

    func delete(withId id: String) {
        let skills = RealmService.shared.realm.objects(SkillObject.self).where { $0.resumeId == id }
        for object in skills {
            RealmService.shared.deleteObjects(objs: object)
        }
    }
}
