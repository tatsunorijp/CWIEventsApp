//
//  CheckInViewController.swift
//  CWIEventsApp
//
//  Created by Tatsu on 09/08/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
// Ideia retirada de:
// https://github.com/tailec/ios-architecture/blob/master/mvvm-functions-subjects-observables/MVVMFunctionsSubjectsObservables/App/ReposScene/ReposViewController.swift
import RxCocoa
import RxSwift
import UIKit

final class CheckInViewController: BaseViewController {
    
    private let viewModel: CheckInViewModelType
    private let router: CheckInRouting
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var completeNameTextField: RoundedTextField!
    @IBOutlet private weak var emailTextField: RoundedTextField!
    @IBOutlet private weak var confirmCheckInButton: PrimaryButton!
    
    init(withViewModel viewModel: CheckInViewModelType, router: CheckInRouting) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        viewModel.output.isCheckInEnable
            .drive { [weak self] isEnabled in
                self?.confirmCheckInButton.isEnabled = isEnabled
            }
            .disposed(by: disposeBag)
        
        viewModel.output.onCheckinCompleted
            .drive { [weak self] _ in
                guard let self = self else { return }
                Alert.show(
                    in: self,
                    title: "Presença Confirmada",
                    message: "Você confirmou presença neste evento!!") {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.output.isLoading
            .drive(isLoading)
            .disposed(by: disposeBag)
        
        viewModel.output.error
            .drive(error)
            .disposed(by: disposeBag)
        
        completeNameTextField.rx.text.orEmpty
            .bind(to: viewModel.input.didCompleteNameChange)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.input.didEmailChange)
            .disposed(by: disposeBag)
        
        confirmCheckInButton.rx.tap
            .bind(to: viewModel.input.didConfirmCheckIn)
            .disposed(by: disposeBag)
    }
    
    override func prepare() {
        super.prepare()
        observeKeyboardNotifications()
        dismissKeyboardWhenTappedAround()
        confirmCheckInButton.isEnabled = true
        
        prepareUI()
    }
    
    private func prepareUI() {
        titleLabel.text = L10n.CheckIn.Label.title
        completeNameTextField.placeholder = L10n.CheckIn.TextField.Placeholder.completeName
        emailTextField.placeholder = L10n.CheckIn.TextField.Placeholder.email
        confirmCheckInButton.setTitle(L10n.CheckIn.Button.confirm, for: .normal)
    }
}
