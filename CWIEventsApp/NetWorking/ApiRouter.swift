//
//  ApiRouter.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 10/07/21.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    case getEvents
    
    func asURLRequest() throws -> URLRequest {
        let url = try Environment.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getEvents:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getEvents:
            return "events"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .getEvents:
            return [:]
        }
    }
    
}
