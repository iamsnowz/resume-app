//
//  ProjectListSpec.swift
//  ResumeAppTests
//
//  Created by Sarawoot Khunsri on 17/2/2565 BE.
//

import Nimble
import Quick
import UIKit
@testable import ResumeApp

class ProjectListSpec: QuickSpec {

    override func spec() {
        context("show empty data") {
            let viewModel = ProjectDetailsListViewModel(defaultValue: nil)
            
            let sections = viewModel.numberOfSections()
            it("should show number of section is 1") {
                expect(sections).toEventually(equal(1))
            }
            
            for section in 0..<sections {
                let numberOfRow = viewModel.numberOfItems(in: section)
                let sectionType = viewModel.getProjetDetailItemsListSection(in: section)
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
            
            let viewModel = ProjectDetailsListViewModel(defaultValue: nil)
            
            viewModel.listeningToTableViewReloadHandler = {
                reloadSuccess = true
            }
            
            viewModel.didUpdateProjectDetailItemsListHandler = { projectList in
                // data mock has only one item
                it("should get count equal 1") {
                    expect(projectList.count).toEventually(equal(1))
                }
                for project in projectList {
                    it("should show data of education list") {
                        expect(project.projectName).toEventually(equal("Resume"))
                        expect(project.teamSize).toEventually(equal("1"))
                        expect(project.projectSummary).toEventually(equal("This is a resume"))
                        expect(project.technologyUsed).toEventually(equal("RealmSwift Database"))
                        expect(project.role).toEventually(equal("Developer"))
                    }
                }
            }

            viewModel.didSelectAddNewItem = {
                viewModel.updateProjectDetailItem(isUpdate: false, at: nil, projectDetailItem: ResumeMock.projectDetailMock())
            }
            
            viewModel.selectedProjectDetailItem(at: IndexPath(row: 0, section: 0))

            it("should reload status is success") {
                expect(reloadSuccess).toEventually(equal(true))
            }
            
            let sections = viewModel.numberOfSections()
            it("should show number of section is 2") {
                expect(sections).toEventually(equal(2))
            }
            
            for section in 0..<sections {
                let numberOfRow = viewModel.numberOfItems(in: section)
                let sectionType = viewModel.getProjetDetailItemsListSection(in: section)
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
                        let project = viewModel.projectDetailItem(at: IndexPath(row: row, section: 0))
                        it("should show data of project detail") {
                            expect(project.projectName).toEventually(equal("Resume"))
                            expect(project.teamSize).toEventually(equal("1"))
                            expect(project.projectSummary).toEventually(equal("This is a resume"))
                            expect(project.technologyUsed).toEventually(equal("RealmSwift Database"))
                            expect(project.role).toEventually(equal("Developer"))
                        }
                    }
                }
            }
        }
        
        context("show existing data") {
            let viewModel = ProjectDetailsListViewModel(defaultValue: [ResumeMock.projectDetailMock()])
            viewModel.didUpdateProjectDetailItemsListHandler = { projectList in
                // data mock has only one item
                it("should get count equal 1") {
                    expect(projectList.count).toEventually(equal(1))
                }
                for project in projectList {
                    it("should show data of project detail") {
                        expect(project.projectName).toEventually(equal("Resume"))
                        expect(project.teamSize).toEventually(equal("1"))
                        expect(project.projectSummary).toEventually(equal("This is a resume"))
                        expect(project.technologyUsed).toEventually(equal("RealmSwift Database"))
                        expect(project.role).toEventually(equal("Developer"))
                    }
                }
            }
            viewModel.viewDidLoad()
        }
        
        context("delete data") {
            let viewModel = ProjectDetailsListViewModel(defaultValue: [ResumeMock.projectDetailMock()])
            viewModel.viewDidLoad()
            viewModel.didUpdateProjectDetailItemsListHandler = { projectList in
                it("should get count equal 0") {
                    expect(projectList.count).toEventually(equal(0))
                }
            }
            
            viewModel.deleteProjectItem(at: IndexPath(row: 0, section: 0))
        }
        
        context("update data") {
            let viewModel = ProjectDetailsListViewModel(defaultValue: [ResumeMock.projectDetailMock()])
            viewModel.viewDidLoad()
            
            viewModel.didSelectProjectDetailItemHandler = { indexPath, project in
                it("should show old data of project detail") {
                    expect(project.projectName).toEventually(equal("Resume"))
                    expect(project.teamSize).toEventually(equal("1"))
                    expect(project.projectSummary).toEventually(equal("This is a resume"))
                    expect(project.technologyUsed).toEventually(equal("RealmSwift Database"))
                    expect(project.role).toEventually(equal("Developer"))
                }
                let newProject = ProjectDetailItem(projectName: "Update Resume", teamSize: "10", projectSummary: "Update This is a resume", technologyUsed: "Update RealmSwift Database", role: "Update Developer")
                viewModel.updateProjectDetailItem(isUpdate: true, at: indexPath, projectDetailItem: newProject)
            }
            
            viewModel.didUpdateProjectDetailItemsListHandler = { projectList in
                // data mock has only one item
                it("should get count equal 1") {
                    expect(projectList.count).toEventually(equal(1))
                }
                for project in projectList {
                    it("should show new data of work summary") {
                        expect(project.projectName).toEventually(equal("Update Resume"))
                        expect(project.teamSize).toEventually(equal("10"))
                        expect(project.projectSummary).toEventually(equal("Update This is a resume"))
                        expect(project.technologyUsed).toEventually(equal("Update RealmSwift Database"))
                        expect(project.role).toEventually(equal("Update Developer"))
                    }
                }
            }
            
            viewModel.selectedProjectDetailItem(at: IndexPath(row: 0, section: 0))
        }
    }
}
