//
//  EducationEditorViewModel.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import UIKit

protocol EducationEditorViewModelOutput {
    var shouldEnableButtonHandler: ((Bool) -> Void)? { get }
    var didSelectStartYearDateHandler: ((Date) -> Void)? { get }
    var didSelectEndYearDateHandler: ((Date) -> Void)? { get}
    var isUpdateEducationDetailItemHandler: ((EducationDetailItem) -> Void)? { get }
    var finishedWithEducationDetailItemHandler: ((Bool, EducationDetailItem) -> Void)? { get }
}

protocol EducationEditorViewModelInput {
    func viewDidLoad()
    func finish()
    func setGrade(text: String?)
    func selectStartYearDate()
    func selectEndYearDate()
    func setStartYearDate(date: Date)
    func setEndYearDate(date: Date)
    func setCGPA(text: String?)
}

final class EducationEditorViewModel: EducationEditorViewModelInput, EducationEditorViewModelOutput {

    
    private var defaultValue: EducationDetailItem?
    
    init(defaultValue: EducationDetailItem?) {
        self.defaultValue = defaultValue
    }
    
    private var isUpdate: Bool = false
    
    private var grade: String = "" {
        didSet {
            evaluateData()
        }
    }
    
    private var startYearDate: Date? {
        didSet {
            evaluateData()
        }
    }
    
    private var endYearDate: Date? {
        didSet {
            evaluateData()
        }
    }
    
    private var cgpa: String = "" {
        didSet {
            evaluateData()
        }
    }
    
    private func evaluateData() {
        let isEnabled = grade != "" && startYearDate != nil  && endYearDate != nil && cgpa != ""
        shouldEnableButtonHandler?(isEnabled)
    }
    
    // MARK: - Output
    var shouldEnableButtonHandler: ((Bool) -> Void)?
    var didSelectStartYearDateHandler: ((Date) -> Void)?
    var didSelectEndYearDateHandler: ((Date) -> Void)?
    var isUpdateEducationDetailItemHandler: ((EducationDetailItem) -> Void)?
    var finishedWithEducationDetailItemHandler: ((Bool, EducationDetailItem) -> Void)?
    
    // MARK: - Input
    func setGrade(text: String?) {
        guard let text = text else {
            return
        }
        grade = text
    }
    
    func setStartYearDate(date: Date) {
        startYearDate = date
    }
    
    func setEndYearDate(date: Date) {
        endYearDate = date
    }
    
    func selectStartYearDate() {
        didSelectStartYearDateHandler?(startYearDate ?? Date())
    }
    
    func selectEndYearDate() {
        didSelectEndYearDateHandler?(endYearDate ?? Date())
    }
    
    func setCGPA(text: String?) {
        guard let text = text else {
            return
        }
        cgpa = text
    }
    
    func viewDidLoad() {
        isUpdate = defaultValue != nil
        if isUpdate, let defaultValue = defaultValue {
            setGrade(text: defaultValue.grade)
            setStartYearDate(date: defaultValue.startYear)
            setEndYearDate(date: defaultValue.endYear)
            isUpdateEducationDetailItemHandler?(defaultValue)
        }
    }
    
    func finish() {
        guard let startYearDate = startYearDate, let endYearDate = endYearDate else {
            return
        }

        let educationDetailItem = EducationDetailItem(grade: grade, startYear: startYearDate, endYear: endYearDate, cgpa: cgpa)
        finishedWithEducationDetailItemHandler?(isUpdate, educationDetailItem)
    }

}
