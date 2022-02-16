//
//  ResumeItem.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 16/2/2565 BE.
//

import UIKit

struct ResumeItem {
    let id: String
    let profileImageData: Data?
    let resumeTitle: String
    let firstname: String
    let lastname: String
    let mobileNumber: String
    let emailAddress: String
    let residenceAddress: String
    let careerObjective: String
    let totalYearsOfExperience: String
    let workSummary: [WorkSummaryItem]
    let skills: [String]
    let educationDetail: [EducationDetailItem]
    let projectDetail: [ProjectDetailItem]
}
