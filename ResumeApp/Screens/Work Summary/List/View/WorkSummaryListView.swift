//
//  WorkSummaryListView.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import UIKit

final class WorkSummaryListView: UIView, NibFileOwnerLoadable {
    
    // MARK: - IBOutlet Properties
    @IBOutlet private var tableView: DynamicHeightTableView!
    
    // MARK: - Properties
    weak var parentViewController: UIViewController?
    var contentView: UIView!
    private var viewModel: WorkSummaryListViewModel!
    private var workSummaryEditorViewController: WorkSummaryEditorViewController?
    var didUpdateWorkItemsListHandler: (([WorkSummaryItem]) -> Void)?
    
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
        tableView.register(cell: WorkSummaryTableViewCell.self)
        tableView.separatorInset.left = UIScreen.main.bounds.width
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - Binding ViewModel
extension WorkSummaryListView {
    private func bindingViewModel() {
        viewModel = WorkSummaryListViewModel()
        
        // output
        viewModel.listeningToTableViewReloadHandler = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.didUpdateWorkItemsListHandler = { [weak self] workSummaryItemsList in
            self?.didUpdateWorkItemsListHandler?(workSummaryItemsList)
        }
        
        viewModel.didSelectWorkItemHandler = { [weak self] (indexPath, selectedWorkItem) in
            HUD.sheet(for: self?.parentViewController, editAction: { _ in
                self?.showWorkSummaryEditorView(withSelectedWorkItem: selectedWorkItem, at: indexPath)
            }, deleteAction: { _ in
                self?.viewModel.deleteWorkItem(at: indexPath)
            }, cancelAction: { _ in
                
            })
        }
        
        viewModel.didSelectAddNewItem = { [weak self] in
            self?.showWorkSummaryEditorView()
        }
    }
    
    private func showWorkSummaryEditorView(withSelectedWorkItem selectedWorkItem: WorkSummaryItem? = nil, at indexPath: IndexPath? = nil) {
        workSummaryEditorViewController = WorkSummaryEditorViewController.create(withDefaultValue: selectedWorkItem)
        workSummaryEditorViewController?.finishedWithWorkItemHandler = { [weak self] (isUpdate, workItem) in
            self?.viewModel.updateWorkItem(isUpdate: isUpdate, at: indexPath, workItem: workItem)
        }
        parentViewController?.navigationController?.pushViewController(workSummaryEditorViewController!, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension WorkSummaryListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedWorkItem(at: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension WorkSummaryListView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.getWorkSummaryListSection(in: indexPath.section) {
        case .add:
            let cell: AddNewContentTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.display(for: .workSummary)
            return cell
        case .content:
            let cell: WorkSummaryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.display(item: viewModel.workItem(at: indexPath))
            return cell
        }
    }
}

