//
//  RequestBuilder.swift
//  MADNasa
//
//  Created by Mariia Cherniuk on 06/09/2019.
//  Copyright © 2019 Mariia Cherniuk. All rights reserved.
//

import Foundation

protocol RequestBuilding {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    
    func request() -> URLRequest
}

extension RequestBuilding {
    var scheme: String {
        return "https"
    }
    var host: String {
        return "api.nasa.gov"
    }

    var components: URLComponents {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.queryItems = [URLQueryItem(name: "api_key", value: "UTYLe6krJHey6JVqb8I0rSqjRtSezg8U514jvXks")]
        
        return urlComponents
    }
    
    func request() -> URLRequest {
        let url = components.url!
        
        return URLRequest(url: url)
    }
}

class ApodRequestBuilder: RequestBuilding {
    var path: String {
        return "/planetary/apod"
    }
    
    func request() -> URLRequest {
        var components = self.components
        components.path = path
        let url = components.url!
        return URLRequest(url: url)
    }
}
