//
//  EventsBuilder.swift
//  CWIEventsApp
//
//  Created by Tatsu on 06/08/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol EventsBuildable: AnyObject {
    func build() -> UIViewController
}

final class EventsBuilder: Builder, EventsBuildable {
    func build() -> UIViewController {
        let interactor = EventsInteractor()
        let viewModel = EventsViewModel(interactor: interactor)
        let router = EventsRouter(eventDetailsBuilder: EventDetailsBuilder())
        let viewController = EventsViewController(withViewModel: viewModel, router: router)
        router.viewController = viewController

        return viewController
    }
}
