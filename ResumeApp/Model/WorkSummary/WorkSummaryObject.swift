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

class WorkSummarySerializer {
    func serializeWith(resumeId: String, workSummary: [WorkSummaryItem]) {
        for item in workSummary {
            let workSummaryObject = WorkSummaryObject()
            workSummaryObject.resumeId = resumeId
            workSummaryObject.companyName = item.company
            workSummaryObject.startDate = item.startDate
            workSummaryObject.endDate = item.endDate
            RealmService.shared.saveObjects(objs: workSummaryObject)
        }
    }
}
