//
//  ProjectDetailEditorViewModel.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import UIKit

protocol ProjectDetailEditorViewModelOutput {
    var shouldEnableButtonHandler: ((Bool) -> Void)? { get }
    var isUpdateProjectDetailHandler: ((ProjectDetailItem) -> Void)? { get }
}

protocol ProjectDetailEditorViewModelInput {
    func viewDidLoad()
    func setProjectName(text: String?)
    func setTeamSize(text: String?)
    func setProjectSummary(text: String?)
    func setTechnologyUsed(text: String?)
    func setRole(text: String?)
}

final class ProjectDetailEditorViewModel: ProjectDetailEditorViewModelInput, ProjectDetailEditorViewModelOutput {
    
    private var defaultValue: ProjectDetailItem?

    init(defaultValue: ProjectDetailItem?) {
        self.defaultValue = defaultValue
    }
    
    private(set) var isUpdate: Bool = false
    
    var projectDetaiLItem: ProjectDetailItem {
        return ProjectDetailItem(projectName: projectName,
                                 teamSize: teamSize,
                                 projectSummary: projectSummary,
                                 technologyUsed: technologyUsed,
                                 role: role)
    }
    
    private var projectName: String = "" {
        didSet {
            evaluateData()
        }
    }
    
    private var teamSize: String = "" {
        didSet {
            evaluateData()
        }
    }
    
    private var projectSummary: String = "" {
        didSet {
            evaluateData()
        }
    }
    
    private var technologyUsed: String = "" {
        didSet {
            evaluateData()
        }
    }
    
    private var role: String = "" {
        didSet {
            evaluateData()
        }
    }
    
    private func evaluateData() {
        let isEnabled = projectName != "" && teamSize != "" && projectSummary != "" && technologyUsed != "" && role != ""
        shouldEnableButtonHandler?(isEnabled)
    }
    
    // MARK: - Output
    var shouldEnableButtonHandler: ((Bool) -> Void)?
    var isUpdateProjectDetailHandler: ((ProjectDetailItem) -> Void)?
    
    // MARK: - Input
    func setProjectName(text: String?) {
        guard let text = text else {
            return
        }
        projectName = text
    }
    
    func setTeamSize(text: String?) {
        guard let text = text else {
            return
        }
        teamSize = text
    }
    
    func setProjectSummary(text: String?) {
        guard let text = text else {
            return
        }
        projectSummary = text
    }
    
    func setTechnologyUsed(text: String?) {
        guard let text = text else {
            return
        }
        technologyUsed = text
    }
    
    func setRole(text: String?) {
        guard let text = text else {
            return
        }
        role = text
    }
    
    func viewDidLoad() {
        isUpdate = defaultValue != nil
        if isUpdate, let defaultValue = defaultValue {
            setProjectName(text: defaultValue.projectName)
            setTeamSize(text: defaultValue.projectName)
            setProjectSummary(text: defaultValue.projectName)
            setTechnologyUsed(text: defaultValue.projectName)
            setRole(text: defaultValue.projectName)
            isUpdateProjectDetailHandler?(defaultValue)
        }
    }
}
