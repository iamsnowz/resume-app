//
//  ResumeContentViewController.swift
//  ResumeApp
//
//  Created by Sarawoot Khunsri on 15/2/2565 BE.
//

import UIKit

final class ResumeContentViewController: UIViewController {

    // MARK: - IBOutlet Properties
    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var firstnameLabel: UILabel!
    @IBOutlet private var lastnameLabel: UILabel!
    @IBOutlet private var mobileNumberLabel: UILabel!
    @IBOutlet private var emailAddressLabel: UILabel!
    @IBOutlet private var residenceAddressLabel: UILabel!
    @IBOutlet private var careerObjectLabel: UILabel!
    @IBOutlet private var totalYearsOfExperienceLabel: UILabel!
    @IBOutlet private var tableView: DynamicHeightTableView!
    
    // MARK: - Properties
    private var viewModel: ResumeContentViewModel!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindingViewModel()
        setupImageView()
        setupTableView()
        viewModel.viewDidLoad()
    }

    static func create(withResume resume: ResumeItem) -> ResumeContentViewController {
        let viewModel = ResumeContentViewModel(resume: resume)
        let vc = ResumeContentViewController(nibName: ResumeContentViewController.identifier, bundle: nil)
        vc.viewModel = viewModel
        return vc
    }
    
    // MARK: - Setup
    private func setup() {
        view.backgroundColor = .theme.background
    }
    
    private func setupImageView() {
        profileImageView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        profileImageView.layer.borderWidth = 1
    }
    
    private func setupTableView() {
        tableView.register(cell: WorkSummaryContentTableViewCell.self)
        tableView.register(cell: SkillContentTableViewCell.self)
        tableView.register(cell: EducationDetailContentTableViewCell.self)
        tableView.register(cell: ProjectDetailContentTableViewCell.self)
        tableView.backgroundColor = .theme.background
        tableView.separatorInset.left = UIScreen.main.bounds.width
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

// MARK: - Binding ViewModel
extension ResumeContentViewController{
    private func bindingViewModel() {
        // output
        viewModel.displayResumeHandler = { [weak self] resume in
            self?.title = resume.personalDetail.resumeTitle
            self?.profileImageView.image = UIImage(data: resume.personalDetail.profileImageData ?? Data())
            self?.firstnameLabel.text = resume.personalDetail.firstname
            self?.lastnameLabel.text = resume.personalDetail.lastname
            self?.mobileNumberLabel.text = resume.personalDetail.mobileNumber
            self?.emailAddressLabel.text = resume.personalDetail.emailAddress
            self?.residenceAddressLabel.text = resume.personalDetail.residenceAddress
            self?.careerObjectLabel.text = resume.personalDetail.careerObjective
            self?.totalYearsOfExperienceLabel.text = resume.personalDetail.totalYearsOfExperience
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate
extension ResumeContentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

// MARK: - UITableViewDataSource
extension ResumeContentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .theme.background
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        v.addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: v.topAnchor),
            separatorView.leadingAnchor.constraint(equalTo: v.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: v.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 5),
        ])
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "LabelColor")
        label.text = viewModel.titleForHeader(in: section)
        label.font = UIFont.preferredFont(forTextStyle: .body)
        v.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: v.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: 8),
        ])
        return v
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.getResumeContentSection(in: indexPath.section) {
        case .workSummary:
            let cell: WorkSummaryContentTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.display(item: viewModel.workSummaryItem(at: indexPath))
            return cell
        case .skill:
            let cell: SkillContentTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.display(skill: viewModel.skill(at: indexPath))
            return cell
        case .educationDetail:
            let cell: EducationDetailContentTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.display(item: viewModel.educationDetail(at: indexPath))
            return cell
        case .projectDetail:
            let cell: ProjectDetailContentTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.display(item: viewModel.projectDetail(at: indexPath))
            return cell
        }
    }
}
