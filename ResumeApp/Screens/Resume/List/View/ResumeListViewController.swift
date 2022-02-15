//
//  ResumeListViewController.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import UIKit

final class ResumeListViewController: UIViewController {

    // MARK: - IBOutlet Properties
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationItem()
    }

    static func create() -> ResumeListViewController{
        let vc = ResumeListViewController(nibName: ResumeListViewController.identifier, bundle: nil)
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
}

