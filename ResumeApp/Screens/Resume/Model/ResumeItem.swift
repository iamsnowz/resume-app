//
//  ResumeItem.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 16/2/2565 BE.
//

import UIKit

struct ResumeItem {
    let id: String
    let personalDetail: PersonalDetailItem
    let workSummary: [WorkSummaryItem]
    let skills: [String]
    let educationDetail: [EducationDetailItem]
    let projectDetail: [ProjectDetailItem]
}
