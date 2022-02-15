//
//  WorkSummaryListViewModel.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import Foundation

enum WorkSummaryListSection {
    case add
    case content
}

protocol WorkSummaryListViewModelOutput {
    var didUpdateWorkItemsListHandler: (() -> Void)? { get }
    var didSelectAddNewItem: (() -> Void)? { get }
    var didSelectWorkItemHandler: ((IndexPath, WorkSummaryItem) -> Void)? { get }
    
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func getWorkSummaryListSection(in section: Int) -> WorkSummaryListSection
    func workItem(at indexPath: IndexPath) -> WorkSummaryItem
}

protocol WorkSummaryListViewModelInput {
    func updateWorkItem(isUpdate: Bool, at indexPath: IndexPath?, workItem: WorkSummaryItem)
    func selectedWorkItem(at indexPath: IndexPath)
    func deleteWorkItem(at indexPath: IndexPath)
}

final class WorkSummaryListViewModel: WorkSummaryListViewModelInput, WorkSummaryListViewModelOutput {
    
    private(set) var workItemsList: [WorkSummaryItem] = []
    
    // MARK: - Output
    var didUpdateWorkItemsListHandler: (() -> Void)?
    var didSelectAddNewItem: (() -> Void)?
    var didSelectWorkItemHandler: ((IndexPath, WorkSummaryItem) -> Void)?
    
    func numberOfSections() -> Int {
        return workItemsList.isEmpty ? 1 : 2
    }
    
    func numberOfItems(in section: Int) -> Int {
        return getWorkSummaryListSection(in: section) == .add ? 1 : workItemsList.count
    }
    
    func getWorkSummaryListSection(in section: Int) -> WorkSummaryListSection {
        return (workItemsList.isEmpty || section == 1) ? .add : .content
    }
    
    func workItem(at indexPath: IndexPath) -> WorkSummaryItem {
        return workItemsList[indexPath.row]
    }
    
    // MARK: - Input
    func updateWorkItem(isUpdate: Bool, at indexPath: IndexPath?, workItem: WorkSummaryItem) {
        if isUpdate, let row = indexPath?.row {
            workItemsList[row] = workItem
        } else {
            workItemsList.append(workItem)
        }
        didUpdateWorkItemsListHandler?()
    }
    
    func selectedWorkItem(at indexPath: IndexPath) {
        switch getWorkSummaryListSection(in: indexPath.section) {
        case .add:
            didSelectAddNewItem?()
        case .content:
            didSelectWorkItemHandler?(indexPath, workItem(at: indexPath))
        }
    }
    
    func deleteWorkItem(at indexPath: IndexPath) {
        if !workItemsList.isEmpty {
            workItemsList.remove(at: indexPath.row)
            didUpdateWorkItemsListHandler?()
        }
    }
    
}
