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

class SkillSerializer {
    func serializeWith(resumeId: String, skills: [String]) {
        for item in skills {
            let skillObject = SkillObject()
            skillObject.resumeId = resumeId
            skillObject.name = item
            RealmService.shared.saveObjects(objs: skillObject)
        }
    }
}
