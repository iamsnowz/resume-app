//
//  ResumeListSpec.swift
//  ResumeAppTests
//
//  Created by Sarawoot Khunsri on 18/2/2565 BE.
//

import Nimble
import Quick
import UIKit
@testable import ResumeApp

class ResumeListSpec: QuickSpec {

    override func spec() {
        describe("user view resume list") {
            context("show resume list") {
                var result: Bool = false
                let service = ResumeServiceMock(isSuccess: true)
                let viewModel = ResumeListViewModel(service: service)
                
                viewModel.listeningToTableViewReload = {
                    result = true
                }
                
                viewModel.fetchResumeList()
                
                it("should show resume list") {
                    expect(result).toEventually(equal(true))
                }
                
                let numberOfRow = viewModel.numberOfItem(in: 0)
                it("should get number of resume list is 1") {
                    expect(numberOfRow).toEventually(equal(1))
                }
                
                context("select resume") {
                    var resume: ResumeItem!
                    viewModel.didSelectResumeHandler = { indexPath, selectedResume in
                        resume = selectedResume
                    }
                    
                    viewModel.selectedResume(at: IndexPath(row: 0, section: 0))
                    
                    it("should show data of resume") {
                        expect(resume.id).toEventually(equal("1"))
                        expect(resume.personalDetail.resumeTitle).toEventually(equal("resume"))
                        expect(resume.personalDetail.firstname).toEventually(equal("firstname"))
                        expect(resume.personalDetail.lastname).toEventually(equal("lastname"))
                        expect(resume.personalDetail.mobileNumber).toEventually(equal("0123456789"))
                        expect(resume.personalDetail.emailAddress).toEventually(equal("email@email.com"))
                        expect(resume.personalDetail.residenceAddress).toEventually(equal("Thailand"))
                        expect(resume.personalDetail.careerObjective).toEventually(equal("Good Developer"))
                        expect(resume.personalDetail.totalYearsOfExperience).toEventually(equal("5"))
                    }
                }
                
                context("delete resume") {
                    var resume: ResumeItem!
                    var indexPath: IndexPath!
                    var deleteResult: Bool = false
                    viewModel.didSelectResumeHandler = { selectedIndexPath, selectedResume in
                        resume = selectedResume
                        indexPath = selectedIndexPath
                        
                    }
                    
                    viewModel.selectedResume(at: IndexPath(row: 0, section: 0))
                    
                    it("should show data of resume") {
                        expect(resume.id).toEventually(equal("1"))
                        expect(resume.personalDetail.resumeTitle).toEventually(equal("resume"))
                        expect(resume.personalDetail.firstname).toEventually(equal("firstname"))
                        expect(resume.personalDetail.lastname).toEventually(equal("lastname"))
                        expect(resume.personalDetail.mobileNumber).toEventually(equal("0123456789"))
                        expect(resume.personalDetail.emailAddress).toEventually(equal("email@email.com"))
                        expect(resume.personalDetail.residenceAddress).toEventually(equal("Thailand"))
                        expect(resume.personalDetail.careerObjective).toEventually(equal("Good Developer"))
                        expect(resume.personalDetail.totalYearsOfExperience).toEventually(equal("5"))
                    }
                    
                    viewModel.didDeleteResumeHandler = {
                        deleteResult = true
                    }
                    
                    viewModel.delete(at: indexPath)
                    
                    it("should delete resume") {
                        expect(deleteResult).toEventually(equal(true))
                    }
                }
            }
            
            context("show empty list") {
                var result: Bool = false
                let service = ResumeServiceMock(isSuccess: false)
                let viewModel = ResumeListViewModel(service: service)
                
                viewModel.notFoundDataHandler = {
                    result = true
                }
                
                viewModel.fetchResumeList()
                
                it("should show empty data") {
                    expect(result).toEventually(equal(true))
                }
            }
        }
    }

}
