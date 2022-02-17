//
//  ProjectDetailEditorSpec.swift
//  ResumeAppTests
//
//  Created by Sarawoot Khunsri on 17/2/2565 BE.
//

import Nimble
import Quick
import UIKit
@testable import ResumeApp

class ProjectDetailEditorSpec: QuickSpec {
    override func spec() {
        describe("user create a new project detail") {
            context("input project detail") {
                var result: Bool = false
                let viewModel = ProjectDetailEditorViewModel(defaultValue: nil)
                viewModel.shouldEnableButtonHandler = { isEnabled in
                    result = isEnabled
                    viewModel.finish()
                }
                
                viewModel.setProjectName(text: "Resume")
                viewModel.setTeamSize(text: "1")
                viewModel.setProjectSummary(text: "This is a resume")
                viewModel.setTechnologyUsed(text: "RealmSwift Database")
                viewModel.setRole(text: "Developer")
                
                it("should enable create button") {
                    expect(result).toEventually(equal(true))
                }
            }
            
            context("input empty") {
                var result: Bool = false
                let viewModel = ProjectDetailEditorViewModel(defaultValue: nil)
                
                viewModel.shouldEnableButtonHandler = { isEnabled in
                    result = isEnabled
                }
                
                viewModel.setProjectName(text: nil)
                viewModel.setTeamSize(text: nil)
                viewModel.setProjectSummary(text: nil)
                viewModel.setTechnologyUsed(text: nil)
                viewModel.setRole(text: nil)
                
                it("should disable create button") {
                    expect(result).toEventuallyNot(equal(true))
                }
            }
        }
        
        describe("user update a project detail") {
            context("input project detail") {
                var result: Bool = false
                let viewModel = ProjectDetailEditorViewModel(defaultValue: ResumeMock.projectDetailMock())
                
                viewModel.shouldEnableButtonHandler = { isEnabled in
                    result = isEnabled
                    viewModel.finish()
                }
                
                viewModel.viewDidLoad()
                
                it("should enable update button") {
                    expect(result).toEventually(equal(true))
                }
            }
        }
    }
}
