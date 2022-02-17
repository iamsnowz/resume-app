//
//  ResumeListViewModel.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 16/2/2565 BE.
//

import UIKit
import RealmSwift

protocol ResumeListViewModelOutput {
    var listeningToTableViewReload: (() -> Void)? { get }
    var notFoundDataHandler: (() -> Void)? { get }
    var didSelectResumeHandler: ((IndexPath, ResumeItem) -> Void)? { get }
    var didDeleteResumeHandler: (() -> Void)? { get }
    
    func numberOfItem(in section: Int) -> Int
    func resume(at indexPath: IndexPath) -> ResumeItem
}

protocol ResumeListViewModelInput {
    func fetchResumeList()
    
    func selectedResume(at indexPath: IndexPath)
    func delete(at indexPath: IndexPath)
}

final class ResumeListViewModel: ResumeListViewModelInput, ResumeListViewModelOutput {
    private var resumeList: [ResumeItem] = [] {
        didSet {
            listeningToTableViewReload?()
        }
    }
    private let service: ResumeServiceProtocol
    
    init(service: ResumeServiceProtocol) {
        self.service = service
    }
    
    // MARK: - Output
    var listeningToTableViewReload: (() -> Void)?
    var didSelectResumeHandler: ((IndexPath, ResumeItem) -> Void)?
    var notFoundDataHandler: (() -> Void)?
    var didDeleteResumeHandler: (() -> Void)?
    
    func numberOfItem(in section: Int) -> Int {
        return resumeList.count
    }
    
    func resume(at indexPath: IndexPath) -> ResumeItem {
        return resumeList[indexPath.row]
    }
    
    // MARK: - Input
    func selectedResume(at indexPath: IndexPath) {
        didSelectResumeHandler?(indexPath, resume(at: indexPath))
    }
    
    func delete(at indexPath: IndexPath) {
        let id = resume(at: indexPath).id
        service.deleteResume(withId: id) { [weak self] in
            self?.didDeleteResumeHandler?()
        }
    }
    
    func fetchResumeList() {
        service.observe { [weak self] result in
            switch result {
            case .success(let model):
                self?.resumeList = model
            case .failure(let error):
                switch error {
                case .notFoundData:
                    self?.notFoundDataHandler?()
                }
            }
        }
    }
}

