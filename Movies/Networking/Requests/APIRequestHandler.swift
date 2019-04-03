//
//  APIRequestHandler.swift
//  Movies
//
//  Created by Adrian Ortiz on 3/26/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation
import Alamofire

typealias CallResponse<T> = ((ServerResponse<T>) -> Void)?

protocol APIRequestHandler: HandleAlamoResponse {
    // Call Alomofire to do the request
    //  - Parameters:
    //    - decoder: implentation of codable
    //    - completation: result of the request
    
    func send<T: CodableInit>(_ decoder: T.Type, completation: CallResponse<T>)
}

extension APIRequestHandler where Self: URLRequestConvertible {
    
    func send<T: CodableInit>(_ decoder: T.Type, completation: CallResponse<T>) {
        request(self).validate().responseData { (response) in
            self.handleResponse(response, completation: completation)
        }
    }
    
}
