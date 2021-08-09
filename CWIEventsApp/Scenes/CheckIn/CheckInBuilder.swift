//
//  CheckInBuilder.swift
//  CWIEventsApp
//
//  Created by Tatsu on 09/08/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CheckInBuildable: AnyObject {
    func build(eventID: String) -> UIViewController
}

final class CheckInBuilder: Builder, CheckInBuildable {
    func build(eventID: String) -> UIViewController {
        let interactor = CheckInInteractor()
        let viewModel = CheckInViewModel(interactor: interactor, eventID: eventID)
        let router = CheckInRouter()
        let viewController = CheckInViewController(withViewModel: viewModel, router: router)
        router.viewController = viewController

        return viewController
    }
}
