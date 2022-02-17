//
//  WorkSummaryListSpec.swift
//  ResumeAppTests
//
//  Created by Sarawoot Khunsri on 17/2/2565 BE.
//

import Nimble
import Quick
import UIKit
@testable import ResumeApp

class WorkSummaryListSpec: QuickSpec {

    override func spec() {
        describe("user view work summary") {
            context("show empty data") {
                let viewModel = WorkSummaryListViewModel(defaultValue: nil)
                
                let sections = viewModel.numberOfSections()
                it("should show number of section is 1") {
                    expect(sections).toEventually(equal(1))
                }
                
                for section in 0..<sections {
                    let numberOfRow = viewModel.numberOfItems(in: section)
                    let sectionType = viewModel.getWorkSummaryListSection(in: section)
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
                
                let viewModel = WorkSummaryListViewModel(defaultValue: nil)
                
                viewModel.listeningToTableViewReloadHandler = {
                    reloadSuccess = true
                }
                
                viewModel.didUpdateWorkItemsListHandler = { workList in
                    // data mock has only one work
                    it("should get count equal 1") {
                        expect(workList.count).toEventually(equal(1))
                    }
                    for item in workList {
                        it("should show data of work summary") {
                            expect(item.company).toEventually(equal("Company"))
                        }
                    }
                }

                viewModel.didSelectAddNewItem = {
                    viewModel.updateWorkItem(isUpdate: false, at: nil, workItem: ResumeMock.workSummaryMock())
                }
                
                viewModel.selectedWorkItem(at: IndexPath(row: 0, section: 0))

                it("should reload status is success") {
                    expect(reloadSuccess).toEventually(equal(true))
                }
                
                let sections = viewModel.numberOfSections()
                it("should show number of section is 2") {
                    expect(sections).toEventually(equal(2))
                }
                
                for section in 0..<sections {
                    let numberOfRow = viewModel.numberOfItems(in: section)
                    let sectionType = viewModel.getWorkSummaryListSection(in: section)
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
                            let work = viewModel.workItem(at: IndexPath(row: row, section: 0))
                            it("should show data of work summary") {
                                expect(work.company).toEventually(equal("Company"))
                            }
                        }
                    }
                }
            }
            
            context("show existing data") {
                let viewModel = WorkSummaryListViewModel(defaultValue: [ResumeMock.workSummaryMock()])
                viewModel.didUpdateWorkItemsListHandler = { workList in
                    // data mock has only one work
                    it("should get count equal 1") {
                        expect(workList.count).toEventually(equal(1))
                    }
                    for item in workList {
                        it("should show data of work summary") {
                            expect(item.company).toEventually(equal("Company"))
                        }
                    }
                }
                viewModel.viewDidLoad()
            }
            
            context("delete data") {
                let viewModel = WorkSummaryListViewModel(defaultValue: [ResumeMock.workSummaryMock()])
                viewModel.viewDidLoad()
                viewModel.didUpdateWorkItemsListHandler = { workList in
                    it("should get count equal 0") {
                        expect(workList.count).toEventually(equal(0))
                    }
                }
                
                viewModel.deleteWorkItem(at: IndexPath(row: 0, section: 0))
            }
            
            context("update data") {
                let viewModel = WorkSummaryListViewModel(defaultValue: [ResumeMock.workSummaryMock()])
                viewModel.viewDidLoad()
                
                viewModel.didSelectWorkItemHandler = { indexPath, work in
                    it("should show old data of work summary") {
                        expect(work.company).toEventually(equal("Company"))
                    }
                    let newWork = WorkSummaryItem(company: "Update Company", startDate: Date(), endDate: Date())
                    viewModel.updateWorkItem(isUpdate: true, at: indexPath, workItem: newWork)
                }
                
                viewModel.selectedWorkItem(at: IndexPath(row: 0, section: 0))
                
                viewModel.didUpdateWorkItemsListHandler = { workList in
                    // data mock has only one work
                    it("should get count equal 1") {
                        expect(workList.count).toEventually(equal(1))
                    }
                    for item in workList {
                        it("should show new data of work summary") {
                            expect(item.company).toEventually(equal("Update Company"))
                        }
                    }
                }
            }
        }
    }
}
