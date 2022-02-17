//
//  WorkSummaryEditorViewModel.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import UIKit

protocol WorkSummaryEditorViewModelOutput {
    var shouldEnableButtonHandler: ((Bool) -> Void)? { get }
    var didSelectStartDateHandler: ((Date) -> Void)? { get }
    var didSelectEndDateHandler: ((Date) -> Void)? { get}
    var isUpdateWorkItemHandler: ((WorkSummaryItem) -> Void)? { get }
    var finishedWithWorkItemHandler: ((Bool, WorkSummaryItem) -> Void)? { get }
}

protocol WorkSummaryEditorViewModelInput {
    func viewDidLoad()
    func finish()
    func setCompany(text: String?)
    func selectStartDate()
    func selectEndDate() 
    func setStartDate(date: Date?)
    func setEndDate(date: Date?)
}

final class WorkSummaryEditorViewModel: WorkSummaryEditorViewModelInput, WorkSummaryEditorViewModelOutput {
    
    private var defaultValue: WorkSummaryItem?
    
    init(defaultValue: WorkSummaryItem?) {
        self.defaultValue = defaultValue
    }
    
    private var isUpdate: Bool = false
    
    private var company: String = "" {
        didSet {
            evaluateData()
        }
    }
    
    private var startDate: Date? {
        didSet {
            evaluateData()
        }
    }
    
    private var endDate: Date? {
        didSet {
            evaluateData()
        }
    }
    
    private func evaluateData() {
        let isEnabled = company != "" && startDate != nil  && endDate != nil
        shouldEnableButtonHandler?(isEnabled)
    }
    
    // MARK: - Output
    var shouldEnableButtonHandler: ((Bool) -> Void)?
    var didSelectStartDateHandler: ((Date) -> Void)?
    var didSelectEndDateHandler: ((Date) -> Void)?
    var isUpdateWorkItemHandler: ((WorkSummaryItem) -> Void)?
    var finishedWithWorkItemHandler: ((Bool, WorkSummaryItem) -> Void)?
    
    // MARK: - Input
    func setCompany(text: String?) {
        guard let text = text else {
            return
        }
        company = text
    }
    
    func setStartDate(date: Date?) {
        startDate = date
    }
    
    func setEndDate(date: Date?) {
        endDate = date
    }
    
    func selectStartDate() {
        didSelectStartDateHandler?(startDate ?? Date())
    }
    
    func selectEndDate() {
        didSelectEndDateHandler?(endDate ?? Date())
    }
    
    func viewDidLoad() {
        isUpdate = defaultValue != nil
        if isUpdate, let defaultValue = defaultValue {
            setCompany(text: defaultValue.company)
            setStartDate(date: defaultValue.startDate)
            setEndDate(date: defaultValue.endDate)
            isUpdateWorkItemHandler?(defaultValue)
        }
    }
    
    func finish() {
        guard let startDate = startDate, let endDate = endDate else {
            return
        }

        let workItem = WorkSummaryItem(company: company, startDate: startDate, endDate: endDate)
        finishedWithWorkItemHandler?(isUpdate, workItem)
    }
}
