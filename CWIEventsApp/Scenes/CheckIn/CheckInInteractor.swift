//
//  CheckInInteractor.swift
//  CWIEventsApp
//
//  Created by Tatsu on 09/08/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift

// sourcery: AutoMockable
protocol CheckInInteractable: AnyObject {
    func confirmCheckIn(eventID: String, email: String, completeName: String) -> Single<Void>
}

final class CheckInInteractor: CheckInInteractable {
    func confirmCheckIn(eventID: String, email: String, completeName: String) -> Single<Void> {
        return ApiClient.confirmCheckIn(eventId: "1", name: "nome", email: "teste")
            .mapToVoid()
            .asSingle()
    }
}
