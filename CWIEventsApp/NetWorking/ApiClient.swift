//
//  ApiClient.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 10/07/21.
//

import Foundation
import RxSwift
import Alamofire

class ApiClient {
    
    static func getEvents() -> Observable<[Event]> {
        return request(ApiRouter.getEvents)
    }
    
    static func confirmCheckIn(
        eventId: String,
        name: String,
        email: String)
    -> Observable<EmptyResponse> {
        return request(ApiRouter.confirmCheckIn(eventid: eventId, name: name, email: email))
    }
    
    private static func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        return Observable<T>.create { observer in
            if !(NetworkReachabilityManager()?.isReachable ?? false) {
                observer.onError(ApiError.noInternetAccess)
            }
            
            let request = AF.request(urlConvertible)
                .responseDecodable { (response: AFDataResponse<T>) in
                    
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        switch response.response?.statusCode {
                        case 400:
                            observer.onError(ApiError.badRequest)
                        case 403:
                            observer.onError(ApiError.forbidden)
                        case 404:
                            observer.onError(ApiError.notFound)
                        case 500:
                            observer.onError(ApiError.internalServerError)
                        default:
                            observer.onError(error)
                        }
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
