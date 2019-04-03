//
//  CodableInit.swift
//  Movies
//
//  Created by Adrian Ortiz on 3/26/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation

protocol CodableInit {
    init(data: Data) throws
}

extension CodableInit where Self: Codable {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: data)
    }
}
