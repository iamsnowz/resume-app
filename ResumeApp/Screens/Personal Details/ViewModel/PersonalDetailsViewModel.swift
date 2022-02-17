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
}

protocol PersonalDetailsViewModelInput {
    func openCameraOrPhotoLibrary()
    
    func setProfileImage(image: UIImage?)
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
                                                    careerObject: careerObject,
                                                    totalYearsOfExperience: totalYearsOfExperience)
            didUserFinishInputData?(personalDetail)
        }   
    }
    
    // MARK: - Output
    var didOpenCameraOrPhotoLibrary: (() -> Void)?
    var didUserFinishInputData: ((PersonalDetailItem) -> Void)?
    
    // MARK: - Input
    func openCameraOrPhotoLibrary() {
        didOpenCameraOrPhotoLibrary?()
    }
    
    func setProfileImage(image: UIImage?) {
        profileImageData = image?.pngData()
    }
    
    func setResumeTitle(text: String?) {
        guard let text = text else {
            return
        }
        resumeTitle = text
    }
    
    func setFirstname(text: String?) {
        guard let text = text else {
            return
        }
        firstname = text
    }
    
    func setLastname(text: String?) {
        guard let text = text else {
            return
        }
        lastname = text
    }
    
    func setMobileNumber(text: String?) {
        guard let text = text else {
            return
        }
        mobileNumber = text
    }
    
    func setEmailAddress(text: String?) {
        guard let text = text else {
            return
        }
        emailAddress = text
    }
    
    func setResidenceAddress(text: String?) {
        guard let text = text else {
            return
        }
        residenceAddress = text
    }
    
    func setCareerObject(text: String?) {
        guard let text = text else {
            return
        }
        careerObject = text
    }
    
    func setTotalYearsOfExperience(text: String?) {
        guard let text = text else {
            return
        }
        totalYearsOfExperience = text
    }
}