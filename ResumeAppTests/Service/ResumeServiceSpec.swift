//
//  ResumeServiceSpec.swift
//  ResumeAppTests
//
//  Created by Sarawoot Khunsri on 17/2/2565 BE.
//

import Nimble
import Quick
import UIKit
@testable import ResumeApp

class ResumeServiceSpec: QuickSpec {
    override func spec() {
        describe("user get resume list") {
            context("show resume list") {
                let service = ResumeServiceMock(isSuccess: true)
                service.observe { result in
                    switch result {
                    case .success(let model):
                        it("should get count is 1") {
                            expect(model.count).toEventually(equal(1))
                        }
                    case .failure:
                        break
                    }
                }
            }
            
            context("show empty list") {
                let service = ResumeServiceMock(isSuccess: false)
                service.observe { result in
                    switch result {
                    case .success:
                       break
                    case .failure(let error):
                        it("should show not found data") {
                            expect(error).toEventually(equal(.notFoundData))
                        }
                    }
                }
            }
            
            context("create resume") {
                var result: Bool = false
                let service = ResumeServiceMock(isSuccess: true)
                service.createOrUpdate(withResumeItem: ResumeMock.resumeItemMock()) {
                    result = true
                    it("should get callback after created here") {
                        expect(result).toEventually(equal(true))
                    }
                }
            }
            
            context("delete resume") {
                var result: Bool = false
                let service = ResumeServiceMock(isSuccess: true)
                let resume = ResumeMock.resumeItemMock()
                service.deleteResume(withId: resume.id) {
                    result = true
                    it("should get callback after deleted here") {
                        expect(result).toEventually(equal(true))
                    }
                }
            }
        }
    }
}
