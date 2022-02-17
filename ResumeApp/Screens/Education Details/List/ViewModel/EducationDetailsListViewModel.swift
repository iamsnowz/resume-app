//
//  EducationDetailsListViewModel.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import UIKit

enum EducationDetailsListSection {
    case add
    case content
}

protocol EducationDetailsListViewModelOutput {
    var didUpdateEducationDetailItemsListHandler: (([EducationDetailItem]) -> Void)? { get }
    var listeningToTableViewReloadHandler: (() -> Void)? { get }
    var didSelectAddNewItem: (() -> Void)? { get }
    var didSelectEducationDetailItemHandler: ((IndexPath, EducationDetailItem) -> Void)? { get }
    
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func getEducationDetailsListSection(in section: Int) -> EducationDetailsListSection
    func educationDetailItem(at indexPath: IndexPath) -> EducationDetailItem
}

protocol EducationDetailsListViewModelInput {
    func viewDidLoad()
    func updateEducationDetailItem(isUpdate: Bool, at indexPath: IndexPath?, educationDetailItem: EducationDetailItem?)
    func selectedEducationDetailItem(at indexPath: IndexPath)
    func deleteEducationDetailItem(at indexPath: IndexPath)
}

final class EducationDetailsListViewModel: EducationDetailsListViewModelInput, EducationDetailsListViewModelOutput {
    private let defaultValue: [EducationDetailItem]?
    init(defaultValue: [EducationDetailItem]?) {
        self.defaultValue = defaultValue
    }
    private var educationDetailsItemList: [EducationDetailItem] = [] {
        didSet {
            didUpdateEducationDetailItemsListHandler?(educationDetailsItemList)
            listeningToTableViewReloadHandler?()
        }
    }
    
    // MARK: - Output
    var didUpdateEducationDetailItemsListHandler: (([EducationDetailItem]) -> Void)?
    var listeningToTableViewReloadHandler: (() -> Void)?
    var didSelectAddNewItem: (() -> Void)?
    var didSelectEducationDetailItemHandler: ((IndexPath, EducationDetailItem) -> Void)?
    
    func numberOfSections() -> Int {
        return educationDetailsItemList.isEmpty ? 1 : 2
    }
    
    func numberOfItems(in section: Int) -> Int {
        return getEducationDetailsListSection(in: section) == .add ? 1 : educationDetailsItemList.count
    }
    
    func getEducationDetailsListSection(in section: Int) -> EducationDetailsListSection {
        return (educationDetailsItemList.isEmpty || section == 1) ? .add : .content
    }
    
    func educationDetailItem(at indexPath: IndexPath) -> EducationDetailItem {
        return educationDetailsItemList[indexPath.row]
    }
    
    // MARK: - Input
    func viewDidLoad() {
        if let defaultValue = defaultValue {
            educationDetailsItemList = defaultValue
        }
    }
    
    func updateEducationDetailItem(isUpdate: Bool, at indexPath: IndexPath?, educationDetailItem: EducationDetailItem?) {
        guard let educationDetailItem = educationDetailItem else {
            return
        }
        
        if isUpdate, let row = indexPath?.row {
            educationDetailsItemList[row] = educationDetailItem
        } else {
            educationDetailsItemList.append(educationDetailItem)
        }
    }
    
    func selectedEducationDetailItem(at indexPath: IndexPath) {
        switch getEducationDetailsListSection(in: indexPath.section) {
        case .add:
            didSelectAddNewItem?()
        case .content:
            didSelectEducationDetailItemHandler?(indexPath, educationDetailItem(at: indexPath))
        }
    }
    
    func deleteEducationDetailItem(at indexPath: IndexPath) {
        if !educationDetailsItemList.isEmpty {
            educationDetailsItemList.remove(at: indexPath.row)
        }
    }
}
