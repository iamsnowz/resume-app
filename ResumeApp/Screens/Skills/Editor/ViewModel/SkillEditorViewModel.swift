//
//  SkillEditorViewModel.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import Foundation

protocol SkillEditorViewModelOutput {
    var shouldEnableButtonHandler: ((Bool) -> Void)? { get }
    var isUpdateSkillHandler: ((String?) -> Void)? { get }
    var finishedWithSkillHandler: ((Bool, String) -> Void)? { get }
}

protocol SkillEditorViewModelInput {
    func viewDidLoad()
    func finish()
    func setSkill(text: String?)
}

final class SkillEditorViewModel: SkillEditorViewModelInput, SkillEditorViewModelOutput {
    private var defaultValue: String?
    
    init(defaultValue: String?) {
        self.defaultValue = defaultValue
    }
    
    private(set) var skill: String = "" {
        didSet {
            evaluateData()
        }
    }
    private(set) var isUpdate: Bool = false
    
    private func evaluateData() {
        let isEnabled: Bool = skill != ""
        shouldEnableButtonHandler?(isEnabled)
    }
    
    // MARK: - Output
    var shouldEnableButtonHandler: ((Bool) -> Void)?
    var isUpdateSkillHandler: ((String?) -> Void)?
    var finishedWithSkillHandler: ((Bool, String) -> Void)?
    
    // MARK: - Input
    func setSkill(text: String?) {
        guard let text = text else {
            return
        }
        skill = text
    }
    
    func viewDidLoad() {
        isUpdate = defaultValue != nil
        if isUpdate {
            setSkill(text: defaultValue)
            isUpdateSkillHandler?(defaultValue)
        }
    }
    
    func finish() {
        finishedWithSkillHandler?(isUpdate, skill)
    }
}
