//
//  EducationListSpec.swift
//  ResumeAppTests
//
//  Created by Sarawoot Khunsri on 17/2/2565 BE.
//

import Nimble
import Quick
import UIKit
@testable import ResumeApp

class EducationListSpec: QuickSpec {

    override func spec() {
        describe("user view education list") {
            context("show empty data") {
                let viewModel = EducationDetailsListViewModel(defaultValue: nil)
                
                let sections = viewModel.numberOfSections()
                it("should show number of section is 1") {
                    expect(sections).toEventually(equal(1))
                }
                
                for section in 0..<sections {
                    let numberOfRow = viewModel.numberOfItems(in: section)
                    let sectionType = viewModel.getEducationDetailsListSection(in: section)
                    switch sectionType {
                    case .add:
                        it("should show number of section is 1") {
                            expect(numberOfRow).toEventually(equal(1))
                        }
                    case .content:
                        // expect 1 because mock data is only zero
                        it("should show number of section is 0") {
                            expect(numberOfRow).toEventually(equal(0))
                        }
                    }
                }
            }
            context("create data") {
                var reloadSuccess: Bool = false
                
                let viewModel = EducationDetailsListViewModel(defaultValue: nil)
                
                viewModel.listeningToTableViewReloadHandler = {
                    reloadSuccess = true
                }
                
                viewModel.didUpdateEducationDetailItemsListHandler = { eduationList in
                    // data mock has only one item
                    it("should get count equal 1") {
                        expect(eduationList.count).toEventually(equal(1))
                    }
                    for education in eduationList {
                        it("should show data of education list") {
                            expect(education.grade).toEventually(equal("XII"))
                            expect(education.cgpa).toEventually(equal("4.00"))
                        }
                    }
                }

                viewModel.didSelectAddNewItem = {
                    viewModel.updateEducationDetailItem(isUpdate: false, at: nil, educationDetailItem: ResumeMock.educationDetailMock())
                }
                
                viewModel.selectedEducationDetailItem(at: IndexPath(row: 0, section: 0))

                it("should reload status is success") {
                    expect(reloadSuccess).toEventually(equal(true))
                }
                
                let sections = viewModel.numberOfSections()
                it("should show number of section is 2") {
                    expect(sections).toEventually(equal(2))
                }
                
                for section in 0..<sections {
                    let numberOfRow = viewModel.numberOfItems(in: section)
                    let sectionType = viewModel.getEducationDetailsListSection(in: section)
                    switch sectionType {
                    case .add:
                        it("should show number of section is 1") {
                            expect(numberOfRow).toEventually(equal(1))
                        }
                    case .content:
                        // expect 1 because mock data is only one
                        it("should show number of section is 1") {
                            expect(numberOfRow).toEventually(equal(1))
                        }
                        
                        for row in 0..<numberOfRow {
                            let education = viewModel.educationDetailItem(at: IndexPath(row: row, section: 0))
                            it("should show data of education detail") {
                                expect(education.grade).toEventually(equal("XII"))
                                expect(education.cgpa).toEventually(equal("4.00"))
                            }
                        }
                    }
                }
            }
            
            context("show existing data") {
                let viewModel = EducationDetailsListViewModel(defaultValue: [ResumeMock.educationDetailMock()])
                viewModel.didUpdateEducationDetailItemsListHandler = { educationList in
                    // data mock has only one item
                    it("should get count equal 1") {
                        expect(educationList.count).toEventually(equal(1))
                    }
                    for education in educationList {
                        it("should show data of education detail") {
                            expect(education.grade).toEventually(equal("XII"))
                            expect(education.cgpa).toEventually(equal("4.00"))
                        }
                    }
                }
                viewModel.viewDidLoad()
            }
            
            context("delete data") {
                let viewModel = EducationDetailsListViewModel(defaultValue: [ResumeMock.educationDetailMock()])
                viewModel.viewDidLoad()
                viewModel.didUpdateEducationDetailItemsListHandler = { educationList in
                    it("should get count equal 0") {
                        expect(educationList.count).toEventually(equal(0))
                    }
                }
                
                viewModel.deleteEducationDetailItem(at: IndexPath(row: 0, section: 0))
            }
            
            context("update data") {
                let viewModel = EducationDetailsListViewModel(defaultValue: [ResumeMock.educationDetailMock()])
                viewModel.viewDidLoad()
                
                viewModel.didSelectEducationDetailItemHandler = { indexPath, education in
                    it("should show old data of education detail") {
                        expect(education.grade).toEventually(equal("XII"))
                        expect(education.cgpa).toEventually(equal("4.00"))
                    }
                    let newEducation = EducationDetailItem(grade: "Update XII", startYear: Date(), endYear: Date(), cgpa: "3.5")
                    viewModel.updateEducationDetailItem(isUpdate: true, at: indexPath, educationDetailItem: newEducation)
                }
                
                viewModel.didUpdateEducationDetailItemsListHandler = { educationList in
                    // data mock has only one item
                    it("should get count equal 1") {
                        expect(educationList.count).toEventually(equal(1))
                    }
                    for education in educationList {
                        it("should show new data of work summary") {
                            expect(education.grade).toEventually(equal("Update XII"))
                            expect(education.cgpa).toEventually(equal("3.5"))
                        }
                    }
                }
                
                viewModel.selectedEducationDetailItem(at: IndexPath(row: 0, section: 0))
            }
        }
    }

}
