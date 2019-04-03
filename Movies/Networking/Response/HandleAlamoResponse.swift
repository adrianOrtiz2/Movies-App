//
//  HandleAlamoResponse.swift
//  Movies
//
//  Created by Adrian Ortiz on 3/26/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation
import Alamofire

protocol HandleAlamoResponse {
    // Handle response
    // - Parameters:
    //   - response: response from network
    //   - completation: processing the json response
    
    func handleResponse<T: CodableInit>(_ response: DataResponse<Data>, completation: CallResponse<T>)
}

extension HandleAlamoResponse {
    func handleResponse<T: CodableInit>(_ response: DataResponse<Data>, completation: CallResponse<T>) {
        switch response.result {
        case .failure(let error):
            completation?(ServerResponse<T>.failure(error as? LocalizedError))
        case .success(let value):
            do {
                let model = try T(data: value)
                completation?(ServerResponse<T>.success(model))
            } catch {
                completation?(ServerResponse<T>.failure(error as? LocalizedError))
            }
        }
    }
}
