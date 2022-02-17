//
//  ResumeMock.swift
//  ResumeAppTests
//
//  Created by Sarawoot Khunsri on 17/2/2565 BE.
//

import UIKit

@testable import ResumeApp

struct ResumeMock {
    private init() { }
    static func resumeItemMock() -> ResumeItem {
        return ResumeItem(id: "1", personalDetail: personalDetailMock(), workSummary: [workSummaryMock()], skills: [skillMock()], educationDetail: [educationDetailMock()], projectDetail: [projectDetailMock()])
    }
    static func personalDetailMock() -> PersonalDetailItem {
        return PersonalDetailItem(profileImageData: Data(), resumeTitle: "resume", firstname: "firstname", lastname: "lastname", mobileNumber: "0123456789", emailAddress: "email@email.com", residenceAddress: "Thailand", careerObjective: "Good Developer", totalYearsOfExperience: "5")
    }
    
    static func workSummaryMock() -> WorkSummaryItem {
        return WorkSummaryItem(company: "Company", startDate: Date(), endDate: Date())
    }
    
    static func skillMock() -> String {
        return "Swift"
    }
    
    static func educationDetailMock() -> EducationDetailItem {
        return EducationDetailItem(grade: "XII", startYear: Date(), endYear: Date(), cgpa: "4.00")
    }
    static func projectDetailMock() -> ProjectDetailItem {
        return ProjectDetailItem(projectName: "Resume", teamSize: "1", projectSummary: "This is a resume", technologyUsed: "RealmSwift Database", role: "Developer")
    }
}
