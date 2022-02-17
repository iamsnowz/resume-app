//
//  ResumeServiceMock.swift
//  ResumeAppTests
//
//  Created by Sarawoot Khunsri on 17/2/2565 BE.
//

import RealmSwift
@testable import ResumeApp

class ResumeServiceMock: ResumeServiceProtocol {
    
    private let isSuccess: Bool
    
    init(isSuccess: Bool) {
        self.isSuccess = isSuccess
    }
    
    func createOrUpdate(withResumeItem model: ResumeItem, completion: (() -> Void)?) {
        completion?()
    }
    func deleteResume(withId id: String, _ completion: (() -> Void)?) {
        completion?()
    }
    
    func observe(completion: ((Result<[ResumeItem], ServiceError>) -> Void)?) {
        if isSuccess {
            let list: [ResumeItem] = [
                ResumeMock.resumeItemMock()
            ]
            completion?(.success(list))
        } else {
            completion?(.failure(.notFoundData))
        }
    }
}
