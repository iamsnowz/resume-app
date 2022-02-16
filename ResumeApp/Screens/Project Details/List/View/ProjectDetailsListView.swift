//
//  ProjectDetailsListView.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import UIKit

final class ProjectDetailsListView: UIView, NibFileOwnerLoadable {
    
    // MARK: - IBOutlet Properties
    @IBOutlet private var tableView: DynamicHeightTableView!
    
    // MARK: - Properties
    weak var parentViewController: UIViewController?
    var contentView: UIView!
    private var viewModel: ProjectDetailsListViewModel!
    private var projectDetailEditorViewController: ProjectDetailEditorViewController?
    var didUpdateProjectDetailItemsListHandler: (([ProjectDetailItem]) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
        setup()
        bindingViewModel()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
        setup()
        bindingViewModel()
        setupTableView()
    }
    
    // MARK: - Setup
    private func setup() {
        contentView.backgroundColor = .theme.background
    }

    private func setupTableView() {
        tableView.backgroundColor = .theme.background
        tableView.register(cell: AddNewContentTableViewCell.self)
        tableView.register(cell: ProjectDetailTableViewCell.self)
        tableView.separatorInset.left = UIScreen.main.bounds.width
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - Binding ViewModel
extension ProjectDetailsListView {
    private func bindingViewModel() {
        viewModel = ProjectDetailsListViewModel()
        
        // output
        
        viewModel.listeningToTableViewReloadHandler = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.didUpdateProjectDetailItemsListHandler = { [weak self] projectDetailItemsList in
            self?.didUpdateProjectDetailItemsListHandler?(projectDetailItemsList)
        }
        
        viewModel.didSelectProjectDetailItemHandler = { [weak self] (indexPath, selectedProjectDetailItem) in
            HUD.sheet(for: self?.parentViewController, editAction: { _ in
                self?.showProjectDetailEditorView(withSelectedProjetDetailItem: selectedProjectDetailItem, at: indexPath)
            }, deleteAction: { _ in
                self?.viewModel.deleteProjectItem(at: indexPath)
            }, cancelAction: { _ in
                
            })
        }
        
        viewModel.didSelectAddNewItem = { [weak self] in
            self?.showProjectDetailEditorView()
        }
    }
    
    private func showProjectDetailEditorView(withSelectedProjetDetailItem selectedProjectDetailItem: ProjectDetailItem? = nil, at indexPath: IndexPath? = nil) {
        projectDetailEditorViewController = ProjectDetailEditorViewController.create(withDefaultValue: selectedProjectDetailItem)
        projectDetailEditorViewController?.finishedWithProjectDetailItemHandler = { [weak self] (isUpdate, projectDetailItem) in
            self?.viewModel.updateProjectDetailItem(isUpdate: isUpdate, at: indexPath, projectDetailItem: projectDetailItem)
        }
        parentViewController?.navigationController?.pushViewController(projectDetailEditorViewController!, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension ProjectDetailsListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedProjectDetailItem(at: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension ProjectDetailsListView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.getProjetDetailItemsListSection(in: indexPath.section) {
        case .add:
            let cell: AddNewContentTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.display(for: .projectDetail)
            return cell
        case .content:
            let cell: ProjectDetailTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.display(item: viewModel.projectDetailItem(at: indexPath))
            return cell
        }
    }
}

