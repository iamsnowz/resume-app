//
//  ProjectDetailsListViewModel.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import UIKit

enum ProjectDetailsListSection {
    case add
    case content
}

protocol ProjectDetailsListViewModelOutput {
    var didUpdateProjectDetailItemsListHandler: (([ProjectDetailItem]) -> Void)? { get }
    var listeningToTableViewReloadHandler: (() -> Void)? { get }
    var didSelectAddNewItem: (() -> Void)? { get }
    var didSelectProjectDetailItemHandler: ((IndexPath, ProjectDetailItem) -> Void)? { get }
    
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func getProjetDetailItemsListSection(in section: Int) -> ProjectDetailsListSection
    func projectDetailItem(at indexPath: IndexPath) -> ProjectDetailItem
}

protocol ProjectDetailsListViewModelInput {
    func updateProjectDetailItem(isUpdate: Bool, at indexPath: IndexPath?, projectDetailItem: ProjectDetailItem)
    func selectedProjectDetailItem(at indexPath: IndexPath)
    func deleteProjectItem(at indexPath: IndexPath)
}

final class ProjectDetailsListViewModel: ProjectDetailsListViewModelInput, ProjectDetailsListViewModelOutput {
    
    private var projectDetailItemsList: [ProjectDetailItem] = [] {
        didSet {
            didUpdateProjectDetailItemsListHandler?(projectDetailItemsList)
            listeningToTableViewReloadHandler?()
        }
    }
    
    // MARK: - Output
    var didUpdateProjectDetailItemsListHandler: (([ProjectDetailItem]) -> Void)?
    var listeningToTableViewReloadHandler: (() -> Void)?
    var didSelectAddNewItem: (() -> Void)?
    var didSelectProjectDetailItemHandler: ((IndexPath, ProjectDetailItem) -> Void)?
    
    func numberOfSections() -> Int {
        return projectDetailItemsList.isEmpty ? 1 : 2
    }
    
    func numberOfItems(in section: Int) -> Int {
        return getProjetDetailItemsListSection(in: section) == .add ? 1 : projectDetailItemsList.count
    }
    
    func getProjetDetailItemsListSection(in section: Int) -> ProjectDetailsListSection {
        return (projectDetailItemsList.isEmpty || section == 1) ? .add : .content
    }
    
    func projectDetailItem(at indexPath: IndexPath) -> ProjectDetailItem {
        return projectDetailItemsList[indexPath.row]
    }
    
    // MARK: - Input
    func updateProjectDetailItem(isUpdate: Bool, at indexPath: IndexPath?, projectDetailItem: ProjectDetailItem) {
        if isUpdate, let row = indexPath?.row {
            projectDetailItemsList[row] = projectDetailItem
        } else {
            projectDetailItemsList.append(projectDetailItem)
        }
    }
    
    func selectedProjectDetailItem(at indexPath: IndexPath) {
        switch getProjetDetailItemsListSection(in: indexPath.section) {
        case .add:
            didSelectAddNewItem?()
        case .content:
            didSelectProjectDetailItemHandler?(indexPath, projectDetailItem(at: indexPath))
        }
    }
    
    func deleteProjectItem(at indexPath: IndexPath) {
        if !projectDetailItemsList.isEmpty {
            projectDetailItemsList.remove(at: indexPath.row)
        }
    }
}
