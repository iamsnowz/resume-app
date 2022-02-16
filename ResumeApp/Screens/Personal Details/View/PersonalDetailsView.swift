//
//  PersonalDetailsView.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 16/2/2565 BE.
//

import UIKit
import Photos

final class PersonalDetailsView: UIView, NibFileOwnerLoadable {

    // MARK: - IBOutlet Properties
    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var cameraPhotoLibraryButton: UIButton!
    
    // TextField
    @IBOutlet private var resumeTitleTextField: UITextField!
    @IBOutlet private var firstnameTextField: UITextField!
    @IBOutlet private var lastnameTextField: UITextField!
    @IBOutlet private var mobileNumberTextField: UITextField!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var totalYearsOfExperienceTextField: UITextField!
    
    // TextView
    @IBOutlet private var residenceAddressTextView: UITextView!
    @IBOutlet private var careerObjectTextView: UITextView!
    
    // MARK: - Properties
    private var viewModel: PersonalDetailsViewModel!
    
    weak var parentViewController: UIViewController?
    private var imagePickerController = UIImagePickerController()
    
    var contentView: UIView!
    
    var didUserFinishInputData: ((PersonalDetailItem) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
        setup()
        bindingViewModel()
        setupProfileImageView()
        setupTextField()
        setupTextView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
        setup()
        bindingViewModel()
        setupProfileImageView()
        setupTextField()
        setupTextView()
    }
    
    // MARK: - Action
    @IBAction private func cameraPhotoLibraryTapped() {
        viewModel.openCameraOrPhotoLibrary()
    }
    
    @IBAction private func textFieldEditingChanged(_ textField: UITextField) {
        switch textField {
        case resumeTitleTextField:
            viewModel.setResumeTitle(text: textField.text)
        case firstnameTextField:
            viewModel.setFirstname(text: textField.text)
        case lastnameTextField:
            viewModel.setLastname(text: textField.text)
        case mobileNumberTextField:
            viewModel.setMobileNumber(text: textField.text)
        case emailTextField:
            viewModel.setEmailAddress(text: textField.text)
        case totalYearsOfExperienceTextField:
            viewModel.setTotalYearsOfExperience(text: textField.text)
        default: break
        }
    }
    
    // MARK: - Setup
    private func setup() {
        contentView.backgroundColor = .theme.background
    }
    
    private func setupProfileImageView() {
        profileImageView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        profileImageView.layer.borderWidth = 1
        cameraPhotoLibraryButton.setTitle("Add image", for: .normal)
    }
    
    private func setupTextField() {
        // Resume title
        resumeTitleTextField.autocorrectionType = .no
        resumeTitleTextField.backgroundColor = .theme.background
        resumeTitleTextField.placeholder = "Resume title"
        
        // first name
        firstnameTextField.autocorrectionType = .no
        firstnameTextField.backgroundColor = .theme.background
        firstnameTextField.placeholder = "First name"
        
        // last name
        lastnameTextField.autocorrectionType = .no
        lastnameTextField.backgroundColor = .theme.background
        lastnameTextField.placeholder = "First name"
        
        // mobile number
        mobileNumberTextField.keyboardType = .numberPad
        mobileNumberTextField.autocorrectionType = .no
        mobileNumberTextField.backgroundColor = .theme.background
        mobileNumberTextField.placeholder = "Mobile number"
        
        // email
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocorrectionType = .no
        emailTextField.backgroundColor = .theme.background
        emailTextField.placeholder = "Email address"
        
        // total years of experience
        totalYearsOfExperienceTextField.keyboardType = .numberPad
        totalYearsOfExperienceTextField.autocorrectionType = .no
        totalYearsOfExperienceTextField.backgroundColor = .theme.background
        totalYearsOfExperienceTextField.placeholder = "10"
    }
    
    private func setupTextView() {
        // residence
        residenceAddressTextView.delegate = self
        residenceAddressTextView.text = ""
        residenceAddressTextView.autocorrectionType = .no
        residenceAddressTextView.backgroundColor = .theme.background
        residenceAddressTextView.setBorder()
        residenceAddressTextView.setPadding()
        
        // career
        careerObjectTextView.delegate = self
        careerObjectTextView.text = ""
        careerObjectTextView.autocorrectionType = .no
        careerObjectTextView.backgroundColor = .theme.background
        careerObjectTextView.setBorder()
        careerObjectTextView.setPadding()
    }
}

// MARK: - Binding ViewModel
extension PersonalDetailsView {
    private func bindingViewModel() {
        viewModel = PersonalDetailsViewModel()
     
        // output
        viewModel.didOpenCameraOrPhotoLibrary = { [weak self] in 
            self?.openCameraPhotoLibraryAlertSheet()
        }
        
        viewModel.didUserFinishInputData = { [weak self] personalDetail  in
            self?.didUserFinishInputData?(personalDetail)
        }
    }
    
    private func openCameraPhotoLibraryAlertSheet() {
        let alertSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        })
        #if targetEnvironment(simulator)
        #else
        let camera = UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
            self?.checkCameraPermission()
        })
        alertSheet.addAction(camera)
        #endif
        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default, handler: { [weak self] _ in
            self?.checkPermissions()
        })
        
        alertSheet.addAction(cancel)
        
        alertSheet.addAction(photoLibrary)
        
        parentViewController?.present(alertSheet, animated: true, completion: nil)
    }
}

// MARK: - UITextViewDelegate
extension PersonalDetailsView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        switch textView {
        case residenceAddressTextView:
            viewModel.setResidenceAddress(text: textView.text)
        case careerObjectTextView:
            viewModel.setCareerObject(text: textView.text)
        default: break
        }
    }
}

extension PersonalDetailsView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        profileImageView.image = image
        cameraPhotoLibraryButton.setTitle("", for: .normal)
        viewModel.setProfileImage(image: image)
        picker.dismiss(animated: true, completion: nil)
    }
}

extension PersonalDetailsView {
    private func openCamera() {
        #if targetEnvironment(simulator)
        #else
        imagePickerController.sourceType = .camera
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        parentViewController?.present(imagePickerController, animated: true)
        #endif
    }
    
    private func checkCameraPermission() {
        if AVCaptureDevice.authorizationStatus(for: .video) ==  AVAuthorizationStatus.authorized {
            openCamera()
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { [weak self] (granted: Bool) -> Void in
                DispatchQueue.main.async {
                    if granted == true {
                        self?.openCamera()
                    } else {
                        self?.alertSetting()
                    }
                }
           })
        }
    }
    
    private func checkPermissions() {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            openPhotoLibrary()
        } else {
            PHPhotoLibrary.requestAuthorization { [weak self] status in
                DispatchQueue.main.async {
                    if status == PHAuthorizationStatus.authorized {
                        self?.openPhotoLibrary()
                    } else {
                        self?.alertSetting()
                    }
                }
            }
        }
    }
    
    private func openPhotoLibrary() {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        parentViewController?.present(imagePickerController, animated: true)
    }
    
    private func alertSetting() {
        let alertController = UIAlertController (title: "We don't have access to your Photos", message: "Go to Settings?", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        parentViewController?.present(alertController, animated: true, completion: nil)
    }
}
