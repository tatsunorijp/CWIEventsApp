//
//  CheckInViewModel.swift
//  CWIEventsApp
//
//  Created by Tatsu on 09/08/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
// Ideia retirada de:
// https://github.com/tailec/ios-architecture/blob/master/mvvm-functions-subjects-observables/MVVMFunctionsSubjectsObservables/App/ReposScene/ReposViewModel.swift

import RxCocoa
import RxSwift

protocol CheckInViewModelInput: AnyObject {
    var didCompleteNameChange: PublishSubject<String> { get }
    var didEmailChange: PublishSubject<String> { get }
    var didConfirmCheckIn: PublishSubject<Void> { get }
}

protocol CheckInViewModelOutput: AnyObject {
    var isCheckInEnable: Driver<Bool> { get }
    var onCheckinCompleted: Driver<Void> { get }
    var isLoading: Driver<Bool> { get }
    var error: Driver<Error> { get }
}

protocol CheckInViewModelType: AnyObject {
    var input: CheckInViewModelInput { get }
    var output: CheckInViewModelOutput { get }
}

final class CheckInViewModel: CheckInViewModelType, CheckInViewModelInput, CheckInViewModelOutput {
    
    var isCheckInEnable: Driver<Bool>
    var onCheckinCompleted: Driver<Void>
    var isLoading: Driver<Bool>
    var error: Driver<Error>
    
    init(interactor: CheckInInteractable, eventID: String) {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        isLoading = activityIndicator.asDriver()
        error = errorTracker.asDriver()
        
        let isValidEmail = didEmailChange.asDriverOnErrorJustComplete()
            .map { $0.isValidEmail }
            .distinctUntilChanged()
        
        let isCompleteNameValid = didCompleteNameChange.asDriverOnErrorJustComplete()
            .map { !$0.isEmpty }
            .distinctUntilChanged()
        
        isCheckInEnable = Driver.combineLatest(isValidEmail, isCompleteNameValid)
            .map { $0 && $1 }
            .startWith(false)
        
        let credentials = Driver.combineLatest(
            didEmailChange.asDriverOnErrorJustComplete(),
            didCompleteNameChange.asDriverOnErrorJustComplete()
        )
        
        onCheckinCompleted = didConfirmCheckIn.asDriverOnErrorJustComplete()
            .withLatestFrom(credentials)
            .flatMap { (email, completeName) in
                interactor.confirmCheckIn(eventID: eventID, email: email, completeName: completeName)
                    .asDriver(trackActivityWith: activityIndicator, onErrorTrackWith: errorTracker)
            }
        
    }
    
    var didConfirmCheckIn: PublishSubject<Void> = PublishSubject()
    var didEmailChange: PublishSubject<String> = PublishSubject()
    var didCompleteNameChange: PublishSubject<String> = PublishSubject()

    var input: CheckInViewModelInput { return self }
    var output: CheckInViewModelOutput { return self }

}
