//
//  PersonalDetailsViewModel.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 16/2/2565 BE.
//

import UIKit

protocol PersonalDetailsViewModelOutput {
    var didOpenCameraOrPhotoLibrary: (() -> Void)? { get }
    var didUserFinishInputData: ((PersonalDetailItem) -> Void)? { get }
    var isUpdatePersonalDetailHandler: ((PersonalDetailItem) -> Void)? { get }
}

protocol PersonalDetailsViewModelInput {
    func viewDidLoad()
    func openCameraOrPhotoLibrary()
    
    func setProfileImage(data: Data?)
    func setResumeTitle(text: String?)
    func setFirstname(text: String?)
    func setLastname(text: String?)
    func setMobileNumber(text: String?)
    func setEmailAddress(text: String?)
    func setResidenceAddress(text: String?)
    func setCareerObject(text: String?)
    func setTotalYearsOfExperience(text: String?)
}

final class PersonalDetailsViewModel: PersonalDetailsViewModelInput, PersonalDetailsViewModelOutput {
    private let defaultValue: PersonalDetailItem?
    
    init(defaultValue: PersonalDetailItem?) {
        self.defaultValue = defaultValue
    }
    
    private var isUpdate: Bool = false
    
    private var profileImageData: Data? { didSet { evaluateData() } }
    private var resumeTitle: String = "" { didSet { evaluateData() } }
    private var firstname: String = "" { didSet { evaluateData() } }
    private var lastname: String = "" { didSet { evaluateData() } }
    private var mobileNumber: String = "" { didSet { evaluateData() } }
    private var emailAddress: String = "" { didSet { evaluateData() } }
    private var residenceAddress: String = ""{ didSet { evaluateData() } }
    private var careerObject: String = "" { didSet { evaluateData() } }
    private var totalYearsOfExperience: String = "" { didSet { evaluateData() } }
    
    private func evaluateData() {
        let isValidateAllField: Bool = profileImageData != nil && resumeTitle != "" && firstname != "" && lastname != "" && mobileNumber != "" && emailAddress != "" && residenceAddress != "" && careerObject != "" && totalYearsOfExperience != ""
        if isValidateAllField {
            let personalDetail = PersonalDetailItem(profileImageData: profileImageData,
                                                    resumeTitle: resumeTitle,
                                                    firstname: firstname,
                                                    lastname: lastname,
                                                    mobileNumber: mobileNumber,
                                                    emailAddress: emailAddress,
                                                    residenceAddress: residenceAddress,
                                                    careerObjective: careerObject,
                                                    totalYearsOfExperience: totalYearsOfExperience)
            didUserFinishInputData?(personalDetail)
        }   
    }
    
    // MARK: - Output
    var didOpenCameraOrPhotoLibrary: (() -> Void)?
    var didUserFinishInputData: ((PersonalDetailItem) -> Void)?
    var isUpdatePersonalDetailHandler: ((PersonalDetailItem) -> Void)?
    
    // MARK: - Input
    func viewDidLoad() {
        isUpdate = defaultValue != nil
        if isUpdate, let defaultValue = defaultValue {
            setProfileImage(data: defaultValue.profileImageData)
            setResumeTitle(text: defaultValue.resumeTitle)
            setFirstname(text: defaultValue.firstname)
            setLastname(text: defaultValue.lastname)
            setMobileNumber(text: defaultValue.mobileNumber)
            setEmailAddress(text: defaultValue.emailAddress)
            setResidenceAddress(text: defaultValue.residenceAddress)
            setCareerObject(text: defaultValue.careerObjective)
            setTotalYearsOfExperience(text: defaultValue.totalYearsOfExperience)
            isUpdatePersonalDetailHandler?(defaultValue)
        }
    }
    
    func openCameraOrPhotoLibrary() {
        didOpenCameraOrPhotoLibrary?()
    }
    
    func setProfileImage(data: Data?) {
        profileImageData = data
    }
    
    func setResumeTitle(text: String?) {
        if let text = text {
            resumeTitle = text
        }
    }
    
    func setFirstname(text: String?) {
        if let text = text {
            firstname = text
        }
    }
    
    func setLastname(text: String?) {
        if let text = text {
            lastname = text
        }
    }
    
    func setMobileNumber(text: String?) {
        if let text = text {
            mobileNumber = text
        }
    }
    
    func setEmailAddress(text: String?) {
        if let text = text {
            emailAddress = text
        }
    }
    
    func setResidenceAddress(text: String?) {
        if let text = text {
            residenceAddress = text
        }
    }
    
    func setCareerObject(text: String?) {
        if let text = text {
            careerObject = text
        }
    }
    
    func setTotalYearsOfExperience(text: String?) {
        if let text = text {
            totalYearsOfExperience = text
        }
    }
}
