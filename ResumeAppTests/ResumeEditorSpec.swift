//
//  ResumeEditorSpec.swift
//  ResumeAppTests
//
//  Created by Sarawoot Khunsri on 17/2/2565 BE.
//

import Nimble
import Quick
import UIKit

@testable import ResumeApp

class ResumeEditorSpec: QuickSpec {
    override func spec() {
        describe("user create resume") {
            context("input all field") {
                var result: Bool = false
                var createSuccess: Bool = false
                let viewModel = ResumeEditorViewModel(defaultValue: nil, service: ResumeServiceMock(isSuccess: true))
                viewModel.shouldEnableButtonHandler = { isEnabled in
                    result = isEnabled
                    viewModel.createOrUpdate()
                }
                viewModel.didCreateOrUpdateFinishHandler = {
                    createSuccess = true
                }
                
                viewModel.setPersonalDetail(personanDetail: ResumeMock.personalDetailMock())
                viewModel.setWorkSummary(workSummary: [ResumeMock.workSummaryMock()])
                viewModel.setSkills(skills: [ResumeMock.skillMock()])
                viewModel.setEducationDetails(educationDetails: [ResumeMock.educationDetailMock()])
                viewModel.setProjectDetails(projectDetails: [ResumeMock.projectDetailMock()])
                
                it("should enable create button") {
                    expect(result).toEventually(equal(true))
                }
                
                it("should create success") {
                    expect(createSuccess).toEventually(equal(true))
                }
            }
            
            context("input all field") {
                var result: Bool = false
                var createSuccess: Bool = false
                let viewModel = ResumeEditorViewModel(defaultValue: nil, service: ResumeServiceMock(isSuccess: true))
                viewModel.shouldEnableButtonHandler = { isEnabled in
                    result = isEnabled
                    viewModel.createOrUpdate()
                }
                viewModel.didCreateOrUpdateFinishHandler = {
                    createSuccess = true
                }
                
                viewModel.setPersonalDetail(personanDetail: ResumeMock.personalDetailMock())
                viewModel.setWorkSummary(workSummary: [ResumeMock.workSummaryMock()])
                viewModel.setSkills(skills: [ResumeMock.skillMock()])
                viewModel.setEducationDetails(educationDetails: [ResumeMock.educationDetailMock()])
                viewModel.setProjectDetails(projectDetails: [ResumeMock.projectDetailMock()])
                
                it("should enable create button") {
                    expect(result).toEventually(equal(true))
                }
                
                it("should create success") {
                    expect(createSuccess).toEventually(equal(true))
                }
            }
        }
        describe("user update resume") {
            context("select resume") {
                var result: Bool = false
                var updateSuccess: Bool = false
                let viewModel = ResumeEditorViewModel(defaultValue: ResumeMock.resumeItemMock(), service: ResumeServiceMock(isSuccess: true))
                viewModel.shouldEnableButtonHandler = { isEnabled in
                    result = isEnabled
                    viewModel.createOrUpdate()
                }
                
                viewModel.didCreateOrUpdateFinishHandler = {
                    updateSuccess = true
                }
                
                viewModel.viewDidLoad()
                
                it("should enable create button") {
                    expect(result).toEventually(equal(true))
                }
                
                it("should create success") {
                    expect(updateSuccess).toEventually(equal(true))
                }
            }
        }
    }
}
