//
//  EducationDetailsListView.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import UIKit

final class EducationDetailsListView: UIView, NibFileOwnerLoadable {
    
    // MARK: - IBOutlet Properties
    @IBOutlet private var tableView: DynamicHeightTableView!
    
    // MARK: - Properties
    weak var parentViewController: UIViewController?
    var contentView: UIView!
    private var viewModel: EducationDetailsListViewModel!
    private var educationEditorViewController: EducationEditorViewController?
    var didUpdateEducationDetailItemsListHandler: (([EducationDetailItem]) -> Void)?
    
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
        tableView.register(cell: EducationDetailTableViewCell.self)
        tableView.separatorInset.left = UIScreen.main.bounds.width
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - Binding ViewModel
extension EducationDetailsListView {
    private func bindingViewModel() {
        viewModel = EducationDetailsListViewModel()
        
        // output
        viewModel.listeningToTableViewReloadHandler = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.didUpdateEducationDetailItemsListHandler = { [weak self] educationDetailItemsList in
            self?.didUpdateEducationDetailItemsListHandler?(educationDetailItemsList)
        }
        
        viewModel.didSelectEducationDetailItemHandler = { [weak self] (indexPath, selectedEducationDetail) in
            HUD.sheet(for: self?.parentViewController, editAction: { _ in
                self?.showEducationDetailEditorView(withSelectEducationDetail: selectedEducationDetail, at: indexPath)
            }, deleteAction: { _ in
                self?.viewModel.deleteEducationDetailItem(at: indexPath)
            }, cancelAction: { _ in
                
            })
        }
        
        viewModel.didSelectAddNewItem = { [weak self] in
            self?.showEducationDetailEditorView()
        }
    }
    
    private func showEducationDetailEditorView(withSelectEducationDetail selectedEducationDetail: EducationDetailItem? = nil, at indexPath: IndexPath? = nil) {
        educationEditorViewController = EducationEditorViewController.create(withDefaultValue: selectedEducationDetail)
        educationEditorViewController?.finishedWithEducationDetailItemHandler = { [weak self] (isUpdate, educationDetailItem) in
            self?.viewModel.updateEducationDetailItem(isUpdate: isUpdate, at: indexPath, educationDetailItem: educationDetailItem)
        }
        parentViewController?.navigationController?.pushViewController(educationEditorViewController!, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension EducationDetailsListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedEducationDetailItem(at: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension EducationDetailsListView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.getEducationDetailsListSection(in: indexPath.section) {
        case .add:
            let cell: AddNewContentTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.display(for: .educationDetail)
            return cell
        case .content:
            let cell: EducationDetailTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.display(item: viewModel.educationDetailItem(at: indexPath))
            return cell
        }
    }
}

