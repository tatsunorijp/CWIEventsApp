//
//  EventsRouter.swift
//  CWIEventsApp
//
//  Created by Tatsu on 06/08/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol EventsRouting: AnyObject {
    func navigateToEventDetails(event: Event)
}

final class EventsRouter: Router, EventsRouting {
    let eventDetailsBuilder: EventDetailsBuildable
    
    init(eventDetailsBuilder: EventDetailsBuildable) {
        self.eventDetailsBuilder = eventDetailsBuilder
    }
    
    func navigateToEventDetails(event: Event) {
        let eventDetailsVC = eventDetailsBuilder.build(event: event)
        viewController.navigationController?
            .pushViewController(eventDetailsVC, animated: true)
    }
}
