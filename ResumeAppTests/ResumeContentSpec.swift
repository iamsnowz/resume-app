//
//  ResumeContentSpec.swift
//  ResumeAppTests
//
//  Created by Sarawoot Khunsri on 17/2/2565 BE.
//

import Nimble
import Quick
import UIKit
@testable import ResumeApp

class ResumeContentSpec: QuickSpec {
    override func spec() {
        describe("user view resume content") {
            context("") {
                var result: Bool = false
                let viewModel = ResumeContentViewModel(resume: ResumeMock.resumeItemMock())
                viewModel.displayResumeHandler = { resume in
                    result = true
                }
                
                viewModel.viewDidLoad()
                
                it("should show data of resume") {
                    expect(result).toEventually(equal(true))
                }
                
                let sections = viewModel.numberOfSection()
                it("should show number of section is 4") {
                    expect(sections).toEventually(equal(4))
                }
                
                for section in 0..<sections {
                    let numberOfRow = viewModel.numberOfRow(in: section)
                    // expect 1 because mock data is only one
                    it("should show number of section is 1") {
                        expect(numberOfRow).toEventually(equal(1))
                    }
                    
                    let title = viewModel.titleForHeader(in: section)
                    
                    let sectionType = viewModel.getResumeContentSection(in: section)
                    switch sectionType {
                    case .workSummary:
                        for row in 0..<numberOfRow {
                            let work = viewModel.workSummaryItem(at: IndexPath(row: row, section: sectionType.rawValue))
                            it("should show data of work summary") {
                                expect(work.company).toEventually(equal("Company"))
                            }
                        }
                        
                        it("should show data of title of work summary") {
                            expect(title).toEventually(equal(sectionType.title))
                        }
                    case .skill:
                        for row in 0..<numberOfRow {
                            let skill = viewModel.skill(at: IndexPath(row: row, section: sectionType.rawValue))
                            it("should show data of skill") {
                                expect(skill).toEventually(equal("Swift"))
                            }
                        }
                        
                        it("should show data of title of skill") {
                            expect(title).toEventually(equal(sectionType.title))
                        }
                    case .educationDetail:
                        for row in 0..<numberOfRow {
                            let education = viewModel.educationDetail(at: IndexPath(row: row, section: sectionType.rawValue))
                            it("should show data of eduaction detail") {
                                expect(education.grade).toEventually(equal("XII"))
                                expect(education.cgpa).toEventually(equal("4.00"))
                            }
                        }
                        
                        it("should show data of title of eduaction detail") {
                            expect(title).toEventually(equal(sectionType.title))
                        }
                    case .projectDetail:
                        for row in 0..<numberOfRow {
                            let projectDetail = viewModel.projectDetail(at: IndexPath(row: row, section: sectionType.rawValue))
                            it("should show data of project detail") {
                                expect(projectDetail.projectName).toEventually(equal("Resume"))
                                expect(projectDetail.teamSize).toEventually(equal("1"))
                                expect(projectDetail.projectSummary).toEventually(equal("This is a resume"))
                                expect(projectDetail.technologyUsed).toEventually(equal("RealmSwift Database"))
                                expect(projectDetail.role).toEventually(equal("Developer"))
                            }
                        }
                        it("should show data of title of project detail") {
                            expect(title).toEventually(equal(sectionType.title))
                        }
                    }
                }
            }
        }
    }
}
