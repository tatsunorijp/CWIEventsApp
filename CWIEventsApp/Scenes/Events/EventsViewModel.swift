//
//  EventsViewModel.swift
//  CWIEventsApp
//
//  Created by Tatsu on 06/08/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
// Ideia retirada de:
// https://github.com/tailec/ios-architecture/blob/master/mvvm-functions-subjects-observables/MVVMFunctionsSubjectsObservables/App/ReposScene/ReposViewModel.swift

import RxCocoa
import RxSwift

protocol EventsViewModelInput: AnyObject {}

protocol EventsViewModelOutput: AnyObject {}

protocol EventsViewModelType: AnyObject {
    var input: EventsViewModelInput { get }
    var output: EventsViewModelOutput { get }
}

final class EventsViewModel: EventsViewModelType, EventsViewModelInput, EventsViewModelOutput {
    
    init(interactor: EventsInteractable) {}

    var input: EventsViewModelInput { return self }
    var output: EventsViewModelOutput { return self }

}
