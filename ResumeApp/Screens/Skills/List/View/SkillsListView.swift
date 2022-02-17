//
//  SkillsListView.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import UIKit

final class SkillsListView: UIView, NibFileOwnerLoadable {
    
    // MARK: - IBOutlet Properties
    @IBOutlet private var tableView: DynamicHeightTableView!
    
    // MARK: - Properties
    weak var parentViewController: UIViewController?
    var contentView: UIView!
    private var viewModel: SkillsListViewModel!
    private var skillEditorViewController: SkillEditorViewController?
    var didUpdateSkillsListHandler: (([String]) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
        setup()
    }
    
    func setDefaultValue(skills: [String]?) {
        viewModel = SkillsListViewModel(defaultValue: skills)
        setupTableView()
        bindingViewModel()
        viewModel.viewDidLoad()
    }
    
    // MARK: - Setup
    private func setup() {
        contentView.backgroundColor = .theme.background
    }

    private func setupTableView() {
        tableView.backgroundColor = .theme.background
        tableView.register(cell: AddNewContentTableViewCell.self)
        tableView.register(cell: SkillTableViewCell.self)
        tableView.separatorInset.left = UIScreen.main.bounds.width
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - Binding ViewModel
extension SkillsListView {
    private func bindingViewModel() {
        // output
        viewModel.listeningToTableViewReloadHandler = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.didUpdateSkillsListHandler = { [weak self] skillsList in
            self?.didUpdateSkillsListHandler?(skillsList)
        }
        
        viewModel.didSelectSkillHandler = { [weak self] (indexPath, selectedSkill) in
            HUD.sheet(for: self?.parentViewController, editAction: { _ in
                self?.showSkillEditorView(withSelectedSkill: selectedSkill, at: indexPath)
            }, deleteAction: { _ in
                self?.viewModel.deleteSkill(at: indexPath)
            }, cancelAction: { _ in
                
            })
        }
        
        viewModel.didSelectAddNewItem = { [weak self] in
            self?.showSkillEditorView()
        }
    }
    
    private func showSkillEditorView(withSelectedSkill selectedSkill: String? = nil, at indexPath: IndexPath? = nil) {
        skillEditorViewController = SkillEditorViewController.create(withDefaultValue: selectedSkill)
        skillEditorViewController?.finishedWithSkillHandler = { [weak self] (isUpdate, skill) in
            self?.viewModel.updateSkill(isUpdate: isUpdate, at: indexPath, text: skill)
        }
        parentViewController?.navigationController?.pushViewController(skillEditorViewController!, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension SkillsListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedSkill(at: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension SkillsListView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.getSkillsListSection(in: indexPath.section) {
        case .add:
            let cell: AddNewContentTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.display(for: .skill)
            return cell
        case .content:
            let cell: SkillTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.display(skill: viewModel.skill(at: indexPath))
            return cell
        }
    }
}

