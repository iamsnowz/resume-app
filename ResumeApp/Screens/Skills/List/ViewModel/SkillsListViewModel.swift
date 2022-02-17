//
//  SkillsLstViewModel.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import UIKit

enum SkillsListSection {
    case add
    case content
}

protocol SkillsListViewModelOutput {
    var didUpdateSkillsListHandler: (([String]) -> Void)? { get }
    var listeningToTableViewReloadHandler: (() -> Void)? { get }
    var didSelectAddNewItem: (() -> Void)? { get }
    var didSelectSkillHandler: ((IndexPath, String) -> Void)? { get }
    
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func getSkillsListSection(in section: Int) -> SkillsListSection
    func skill(at indexPath: IndexPath) -> String
}

protocol SkillsListViewModellInput {
    func viewDidLoad()
    
    func updateSkill(isUpdate: Bool, at indexPath: IndexPath?, text: String)
    func selectedSkill(at indexPath: IndexPath)
    func deleteSkill(at indexPath: IndexPath)
}

final class SkillsListViewModel: SkillsListViewModellInput, SkillsListViewModelOutput {
    private let defaultValue: [String]?
    init(defaultValue: [String]?) {
        self.defaultValue = defaultValue
    }
    
    private var skillsList: [String] = [] {
        didSet {
            didUpdateSkillsListHandler?(skillsList)
            listeningToTableViewReloadHandler?()
        }
    }
    
    // MARK: - Output
    var didUpdateSkillsListHandler: (([String]) -> Void)?
    var listeningToTableViewReloadHandler: (() -> Void)?
    var didSelectAddNewItem: (() -> Void)?
    var didSelectSkillHandler: ((IndexPath, String) -> Void)?
    
    func numberOfSections() -> Int {
        return skillsList.isEmpty ? 1 : 2
    }
    
    func numberOfItems(in section: Int) -> Int {
        return getSkillsListSection(in: section) == .add ? 1 : skillsList.count
    }
    
    func getSkillsListSection(in section: Int) -> SkillsListSection {
        return (skillsList.isEmpty || section == 1) ? .add : .content
    }
    
    func skill(at indexPath: IndexPath) -> String {
        return skillsList[indexPath.row]
    }
    
    // MARK: - Input
    func viewDidLoad() {
        if let defaultValue = defaultValue {
            skillsList = defaultValue
        }
    }
    
    func updateSkill(isUpdate: Bool, at indexPath: IndexPath? = nil, text: String) {
        if isUpdate, let row = indexPath?.row {
            skillsList[row] = text
        } else {
            skillsList.append(text)
        }
    }
    
    func selectedSkill(at indexPath: IndexPath) {
        switch getSkillsListSection(in: indexPath.section) {
        case .add:
            didSelectAddNewItem?()
        case .content:
            didSelectSkillHandler?(indexPath, skill(at: indexPath))
        }
    }
    
    func deleteSkill(at indexPath: IndexPath) {
        skillsList.remove(at: indexPath.row)
    }
}
