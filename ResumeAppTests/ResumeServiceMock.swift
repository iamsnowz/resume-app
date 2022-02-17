//
//  ResumeServiceMock.swift
//  ResumeAppTests
//
//  Created by Sarawoot Khunsri on 17/2/2565 BE.
//

import RealmSwift
@testable import ResumeApp

class ResumeServiceMock: ResumeServiceProtocol {
    func createOrUpdate(withResumeItem model: ResumeItem, completion: (() -> Void)?) {
        completion?()
    }
    
    func deleteResume(withId id: String) {
        
    }
    
    func observe(completion: ((Result<Results<ResumeObject>, ServiceError>) -> Void)?) {
        
    }
}
