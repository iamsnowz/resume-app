//
//  SkillEditorSpec.swift
//  ResumeAppTests
//
//  Created by Sarawoot Khunsri on 17/2/2565 BE.
//

import Nimble
import Quick
import UIKit
@testable import ResumeApp

class SkillEditorSpec: QuickSpec {

    override func spec() {
        describe("user create a new skill") {
            context("input skill") {
                var result: Bool = false
                let viewModel = SkillEditorViewModel(defaultValue: nil)
                viewModel.shouldEnableButtonHandler = { isEnabled in
                    result = isEnabled
                    viewModel.finish()
                }
                
                viewModel.setSkill(text: "SwiftUI")
                
                it("should enable create button") {
                    expect(result).toEventually(equal(true))
                }
            }
            
            context("input empty") {
                var result: Bool = false
                let viewModel = SkillEditorViewModel(defaultValue: nil)
                viewModel.shouldEnableButtonHandler = { isEnabled in
                    result = isEnabled
                }
                viewModel.setSkill(text: nil)
                
                it("should disable create button") {
                    expect(result).toEventuallyNot(equal(true))
                }
            }
        }
        
        describe("user update a skill") {
            context("input skill") {
                var result: Bool = false
                
                let viewModel = SkillEditorViewModel(defaultValue: ResumeMock.skillMock())
                
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
