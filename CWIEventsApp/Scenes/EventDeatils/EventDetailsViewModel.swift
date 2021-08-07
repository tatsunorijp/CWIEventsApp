//
//  EventDetailsViewModel.swift
//  CWIEventsApp
//
//  Created by Tatsu on 07/08/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
// Ideia retirada de:
// https://github.com/tailec/ios-architecture/blob/master/mvvm-functions-subjects-observables/MVVMFunctionsSubjectsObservables/App/ReposScene/ReposViewModel.swift

import RxCocoa
import RxSwift

protocol EventDetailsViewModelInput: AnyObject {}

protocol EventDetailsViewModelOutput: AnyObject {}

protocol EventDetailsViewModelType: AnyObject {
    var input: EventDetailsViewModelInput { get }
    var output: EventDetailsViewModelOutput { get }
}

final class EventDetailsViewModel: EventDetailsViewModelType, EventDetailsViewModelInput, EventDetailsViewModelOutput {
    
    init(interactor: EventDetailsInteractable, event: Event) {}

    var input: EventDetailsViewModelInput { return self }
    var output: EventDetailsViewModelOutput { return self }

}
