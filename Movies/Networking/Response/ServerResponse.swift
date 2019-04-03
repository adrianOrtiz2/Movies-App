//
//  ServerResponse.swift
//  Movies
//
//  Created by Adrian Ortiz on 3/26/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation

// Response enum to handle results completation

// - success: Request success with codable object
// - failure: Request faild with localized error

enum ServerResponse<T> {
    case success(T), failure(LocalizedError?)
}
