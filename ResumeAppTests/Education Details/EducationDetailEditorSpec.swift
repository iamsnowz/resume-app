//
//  EducationDetailEditorSpec.swift
//  ResumeAppTests
//
//  Created by Sarawoot Khunsri on 17/2/2565 BE.
//

import Nimble
import Quick
import UIKit
@testable import ResumeApp

class EducationDetailEditorSpec: QuickSpec {
    override func spec() {
        describe("user create a new education detail") {
            context("input education detail") {
                var result: Bool = false
                let viewModel = EducationEditorViewModel(defaultValue: nil)
                viewModel.shouldEnableButtonHandler = { isEnabled in
                    result = isEnabled
                    viewModel.finish()
                }
                viewModel.didSelectStartYearDateHandler = { date in
                    viewModel.setStartYearDate(date: date)
                    
                }
                viewModel.didSelectEndYearDateHandler = { date in
                    viewModel.setEndYearDate(date: date)
                }
                viewModel.selectStartYearDate()
                viewModel.selectEndYearDate()
                viewModel.setGrade(text: "XII")
                viewModel.setCGPA(text: "4.00")
                
                it("should enable create button") {
                    expect(result).toEventually(equal(true))
                }
            }
            
            context("input empty") {
                var result: Bool = false
                let viewModel = EducationEditorViewModel(defaultValue: nil)
                
                viewModel.shouldEnableButtonHandler = { isEnabled in
                    result = isEnabled
                }
                
                viewModel.setGrade(text: nil)
                viewModel.setStartYearDate(date: nil)
                viewModel.setEndYearDate(date: nil)
                viewModel.setCGPA(text: nil)
                
                it("should disable create button") {
                    expect(result).toEventuallyNot(equal(true))
                }
            }
        }
        
        describe("user update a education detail") {
            context("input education detail") {
                var result: Bool = false
                let viewModel = EducationEditorViewModel(defaultValue: ResumeMock.educationDetailMock())
                
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
