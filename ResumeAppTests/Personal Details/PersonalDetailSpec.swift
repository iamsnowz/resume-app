//
//  PersonalDetailSpec.swift
//  ResumeAppTests
//
//  Created by Sarawoot Khunsri on 18/2/2565 BE.
//

import Nimble
import Quick
import UIKit
@testable import ResumeApp

class PersonalDetailSpec: QuickSpec {

    override func spec() {
        describe("user input personal detail") {
            context("input all field") {
                var result: Bool = false
                var personalDetail: PersonalDetailItem!
                let viewModel = PersonalDetailsViewModel(defaultValue: nil)
                viewModel.didUserFinishInputData = { data in
                    result = true
                    personalDetail = data
                }
                
                viewModel.setProfileImage(data: Data())
                viewModel.setResumeTitle(text: "resume")
                viewModel.setFirstname(text: "firstname")
                viewModel.setLastname(text: "lastname")
                viewModel.setMobileNumber(text: "0123456789")
                viewModel.setEmailAddress(text: "email@email.com")
                viewModel.setResidenceAddress(text: "Thailand")
                viewModel.setCareerObject(text: "Good Developer")
                viewModel.setTotalYearsOfExperience(text: "5")
                
                it("should get personal detail after validate user input all field") {
                    expect(result).toEventually(equal(true))
                    expect(personalDetail.resumeTitle).toEventually(equal("resume"))
                    expect(personalDetail.firstname).toEventually(equal("firstname"))
                    expect(personalDetail.lastname).toEventually(equal("lastname"))
                    expect(personalDetail.mobileNumber).toEventually(equal("0123456789"))
                    expect(personalDetail.emailAddress).toEventually(equal("email@email.com"))
                    expect(personalDetail.residenceAddress).toEventually(equal("Thailand"))
                    expect(personalDetail.careerObjective).toEventually(equal("Good Developer"))
                    expect(personalDetail.totalYearsOfExperience).toEventually(equal("5"))
                }
                
            }
        }
        
        describe("user update personal detail") {
            context("update resume title") {
                var selectedPersonalDetail: PersonalDetailItem!
                let defaultValue = ResumeMock.personalDetailMock()
                let viewModel = PersonalDetailsViewModel(defaultValue: defaultValue)
                
                viewModel.isUpdatePersonalDetailHandler = { data in
                    selectedPersonalDetail = data
                }
                
                viewModel.viewDidLoad()
                
                viewModel.didUserFinishInputData = { data in
                    it("resume title should change") {
                        expect(selectedPersonalDetail.resumeTitle).toEventuallyNot(equal(data.resumeTitle))
                        expect(data.resumeTitle).toEventually(equal("Update resume"))
                    }
                }
                
                viewModel.setResumeTitle(text: "Update resume")
                
                it("should show data from user selected") {
                    expect(selectedPersonalDetail.resumeTitle).toEventually(equal("resume"))
                    expect(selectedPersonalDetail.firstname).toEventually(equal("firstname"))
                    expect(selectedPersonalDetail.lastname).toEventually(equal("lastname"))
                    expect(selectedPersonalDetail.mobileNumber).toEventually(equal("0123456789"))
                    expect(selectedPersonalDetail.emailAddress).toEventually(equal("email@email.com"))
                    expect(selectedPersonalDetail.residenceAddress).toEventually(equal("Thailand"))
                    expect(selectedPersonalDetail.careerObjective).toEventually(equal("Good Developer"))
                    expect(selectedPersonalDetail.totalYearsOfExperience).toEventually(equal("5"))
                }
            }
            
            describe("user open camera") {
                var result: Bool = false
                let viewModel = PersonalDetailsViewModel(defaultValue: nil)
                viewModel.didOpenCameraOrPhotoLibrary = {
                    result = true
                }
                viewModel.openCameraOrPhotoLibrary()
                
                it("should open camera or library") {
                    expect(result).toEventually(equal(true))
                }
            }
        }
    }

}
