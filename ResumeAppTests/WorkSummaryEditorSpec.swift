//
//  WorkSummaryEditorSpec.swift
//  ResumeAppTests
//
//  Created by Sarawoot Khunsri on 17/2/2565 BE.
//

import Nimble
import Quick
import UIKit
@testable import ResumeApp

class WorkSummaryEditorSpec: QuickSpec {
    override func spec() {
        describe("user create a new work summary") {
            context("input work summary") {
                var result: Bool = false
                let viewModel = WorkSummaryEditorViewModel(defaultValue: nil)
                viewModel.shouldEnableButtonHandler = { isEnabled in
                    result = isEnabled
                    viewModel.finish()
                }
                
                viewModel.didSelectStartDateHandler = { date in
                    viewModel.setStartDate(date: date)
                    
                }
                viewModel.didSelectEndDateHandler = { date in
                    viewModel.setEndDate(date: date)
                }
                
                viewModel.setCompany(text: "Company")
                viewModel.selectStartDate()
                viewModel.selectEndDate()
                
                it("should enable create button") {
                    expect(result).toEventually(equal(true))
                }
            }
            
            context("input empty") {
                var result: Bool = false
                let viewModel = WorkSummaryEditorViewModel(defaultValue: nil)
                
                viewModel.shouldEnableButtonHandler = { isEnabled in
                    result = isEnabled
                }

                viewModel.setCompany(text: nil)
                viewModel.setStartDate(date: nil)
                viewModel.setEndDate(date: nil)
                
                it("should disable create button") {
                    expect(result).toEventuallyNot(equal(true))
                }
            }
        }
        
        describe("user update a work summary") {
            context("input education detail") {
                var result: Bool = false
                let viewModel = WorkSummaryEditorViewModel(defaultValue: ResumeMock.workSummaryMock())
                
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
