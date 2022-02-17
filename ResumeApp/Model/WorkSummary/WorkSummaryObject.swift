//
//  WorkSummaryModel.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 16/2/2565 BE.
//

import UIKit
import RealmSwift

class WorkSummaryObject: Object {
    @Persisted var resumeId = ""
    @Persisted var companyName = ""
    @Persisted var startDate = Date()
    @Persisted var endDate = Date()
}


class WorkSummaryObjectManager {
    func createOrUpdate(resumeId: String, workSummary: [WorkSummaryItem]) {
        delete(withId: resumeId)
        for item in workSummary {
            let workSummaryObject = WorkSummaryObject()
            workSummaryObject.resumeId = resumeId
            workSummaryObject.companyName = item.company
            workSummaryObject.startDate = item.startDate
            workSummaryObject.endDate = item.endDate
            RealmService.shared.saveObjects(objs: workSummaryObject)
        }
    }
    
    func delete(withId id: String) {
        let workSummary = RealmService.shared.realm.objects(WorkSummaryObject.self).where { $0.resumeId == id }
        for object in workSummary {
            RealmService.shared.deleteObjects(objs: object)
        }
    }
}
