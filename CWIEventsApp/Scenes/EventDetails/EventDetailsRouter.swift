//
//  EventDetailsRouter.swift
//  CWIEventsApp
//
//  Created by Tatsu on 07/08/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol EventDetailsRouting: AnyObject {
    func navigateToCheckIn(eventID: String)
}

final class EventDetailsRouter: Router, EventDetailsRouting {
    let checkInBuilder: CheckInBuildable
    
    init(checkInBuilder: CheckInBuildable) {
        self.checkInBuilder = checkInBuilder
    }
    
    func navigateToCheckIn(eventID: String) {
        let checkInVC = checkInBuilder.build(eventID: eventID)
        viewController.navigationController?.pushViewController(checkInVC, animated: true)
    }
}
