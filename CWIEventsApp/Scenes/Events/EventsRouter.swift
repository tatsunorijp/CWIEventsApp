//
//  EventsRouter.swift
//  CWIEventsApp
//
//  Created by Tatsu on 06/08/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol EventsRouting: AnyObject {
    // Declare methods to navigate to other scenes
    // func navigateToOtherScene()
}

final class EventsRouter: Router, EventsRouting {
    /* All the builders needed when navigating must be passed as parameters in the constructor.
     init(otherSceneBuilder: OtherSceneBuildable) {
     self.otherSceneBuilder = otherSceneBuilder
     }

     func navigateToOtherScene() {
     let otherScene = otherSceneBuilder.build()
     viewController.navigationController.pushViewController(otherScene, animated: true)
     }

     private let otherSceneBuilder: OtherSceneBuildable
     */
}
