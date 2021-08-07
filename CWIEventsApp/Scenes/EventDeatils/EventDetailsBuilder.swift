//
//  EventDetailsBuilder.swift
//  CWIEventsApp
//
//  Created by Tatsu on 07/08/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol EventDetailsBuildable: AnyObject {
    func build(event: Event) -> UIViewController
}

final class EventDetailsBuilder: Builder, EventDetailsBuildable {
    func build(event: Event) -> UIViewController {
        let interactor = EventDetailsInteractor()
        let viewModel = EventDetailsViewModel(interactor: interactor, event: event)
        let router = EventDetailsRouter()
        let viewController = EventDetailsViewController(withViewModel: viewModel, router: router)
        router.viewController = viewController

        return viewController
    }
}
