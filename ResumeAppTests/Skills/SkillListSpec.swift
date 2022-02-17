//
//  SkillListSpec.swift
//  ResumeAppTests
//
//  Created by Sarawoot Khunsri on 17/2/2565 BE.
//

import Nimble
import Quick
import UIKit
@testable import ResumeApp

class SkillListSpec: QuickSpec {

    override func spec() {
        describe("user view skill") {
            context("show empty data") {
                let viewModel = SkillsListViewModel(defaultValue: nil)
                
                let sections = viewModel.numberOfSections()
                it("should show number of section is 1") {
                    expect(sections).toEventually(equal(1))
                }
                
                for section in 0..<sections {
                    let numberOfRow = viewModel.numberOfItems(in: section)
                    let sectionType = viewModel.getSkillsListSection(in: section)
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
                
                let viewModel = SkillsListViewModel(defaultValue: nil)
                
                viewModel.listeningToTableViewReloadHandler = {
                    reloadSuccess = true
                }
                
                viewModel.didUpdateSkillsListHandler = { skillList in
                    // data mock has only one item
                    it("should get count equal 1") {
                        expect(skillList.count).toEventually(equal(1))
                    }
                    for item in skillList {
                        it("should show data of skill") {
                            expect(item).toEventually(equal("Swift"))
                        }
                    }
                }

                viewModel.didSelectAddNewItem = {
                    viewModel.updateSkill(isUpdate: false, at: nil, text: ResumeMock.skillMock())
                }
                
                viewModel.selectedSkill(at: IndexPath(row: 0, section: 0))

                it("should reload status is success") {
                    expect(reloadSuccess).toEventually(equal(true))
                }
                
                let sections = viewModel.numberOfSections()
                it("should show number of section is 2") {
                    expect(sections).toEventually(equal(2))
                }
                
                for section in 0..<sections {
                    let numberOfRow = viewModel.numberOfItems(in: section)
                    let sectionType = viewModel.getSkillsListSection(in: section)
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
                            let skill = viewModel.skill(at: IndexPath(row: row, section: 0))
                            it("should show data of skill") {
                                expect(skill).toEventually(equal("Swift"))
                            }
                        }
                    }
                }
            }
            
            context("show existing data") {
                let viewModel = SkillsListViewModel(defaultValue: [ResumeMock.skillMock()])
                viewModel.didUpdateSkillsListHandler = { skillList in
                    // data mock has only one item
                    it("should get count equal 1") {
                        expect(skillList.count).toEventually(equal(1))
                    }
                    for item in skillList {
                        it("should show data of skill") {
                            expect(item).toEventually(equal("Swift"))
                        }
                    }
                }
                viewModel.viewDidLoad()
            }

            context("delete data") {
                let viewModel = SkillsListViewModel(defaultValue: [ResumeMock.skillMock()])
                viewModel.viewDidLoad()
                viewModel.didUpdateSkillsListHandler = { skilLList in
                    it("should get count equal 0") {
                        expect(skilLList.count).toEventually(equal(0))
                    }
                }
                
                viewModel.deleteSkill(at: IndexPath(row: 0, section: 0))
            }
            
            context("update data") {
                let viewModel = SkillsListViewModel(defaultValue: [ResumeMock.skillMock()])
                viewModel.viewDidLoad()
                
                viewModel.didSelectSkillHandler = { indexPath, skill in
                    it("should show old data of skill") {
                        expect(skill).toEventually(equal("Swift"))
                    }
                    let newSkill = "Update Swift"
                    viewModel.updateSkill(isUpdate: true, at: indexPath, text: newSkill)
                }
                
                viewModel.didUpdateSkillsListHandler = { skillList in
                    // data mock has only one item
                    it("should get count equal 1") {
                        expect(skillList.count).toEventually(equal(1))
                    }
                    for item in skillList {
                        it("should show new data of skill") {
                            expect(item).toEventually(equal("Update Swift"))
                        }
                    }
                }
                
                viewModel.selectedSkill(at: IndexPath(row: 0, section: 0))
            }
        }
    }
}
