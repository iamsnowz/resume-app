//
//  ResumeEditorViewController.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import UIKit

final class ResumeEditorViewController: UIViewController {

    // MARK: - IBOutlet Properties
    
    // MARK: - Properties
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    static func create() -> ResumeEditorViewController {
        let vc = ResumeEditorViewController(nibName: ResumeEditorViewController.identifier, bundle: nil)
        return vc
    }
    
    // MARK: - Setup
    private func setup() {
        title = "Creator"
        view.backgroundColor = .theme.background
    }
}
