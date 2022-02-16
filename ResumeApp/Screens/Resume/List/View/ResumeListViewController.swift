//
//  ResumeListViewController.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import UIKit

final class ResumeListViewController: UIViewController {

    // MARK: - IBOutlet Properties
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Properties
    private var viewModel: ResumeListViewModel!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindingViewModel()
        setupNavigationItem()
        setupTableView()
        
        viewModel.fetchResumeList()
    }

    static func create() -> ResumeListViewController{
        let service = ResumeService()
        let viewModel = ResumeListViewModel(service: service)
        let vc = ResumeListViewController(nibName: ResumeListViewController.identifier, bundle: nil)
        vc.viewModel = viewModel
        return vc
    }
    
    // MARK: - Action
    @objc
    private func createNewResumeTapped() {
        let editorView = ResumeEditorViewController.create()
        navigationController?.pushViewController(editorView, animated: true)
    }
    
    // MARK: - Setup
    private func setup() {
        title = "Resume"
        view.backgroundColor = .theme.background
    }
    
    private func setupNavigationItem() {
        let compose = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(createNewResumeTapped))
        navigationItem.rightBarButtonItem = compose
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: ResumeTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ResumeTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .theme.background
        tableView.separatorInset.left = UIScreen.main.bounds.width
    }
}

// MARK: - Binding ViewModel
extension ResumeListViewController {
    private func bindingViewModel() {
        // output
        viewModel.listeningToTableViewReload = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.didSelectResumeHandler = { [weak self] indexPath, selectedResume in
            HUD.sheet(for: self, isViewContent: true, viewContent: { _ in
                let contentView = ResumeContentViewController.create(withResume: selectedResume)
                self?.navigationController?.pushViewController(contentView, animated: true)
            }, editAction: { _ in
                let editorView = ResumeEditorViewController.create()
                self?.navigationController?.pushViewController(editorView, animated: true)
            }, deleteAction: { _ in
                self?.viewModel.delete(at: indexPath)
            }, cancelAction: { _ in
                
            })
           
        }
    }
}

// MARK: - UITableViewDelegate
extension ResumeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedResume(at: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension ResumeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItem(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ResumeTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.display(resume: viewModel.resume(at: indexPath))
        return cell
    }
}
