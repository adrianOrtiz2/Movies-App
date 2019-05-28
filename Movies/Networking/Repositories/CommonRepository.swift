//
//  CommonRepository.swift
//  Movies
//
//  Created by Adrian Ortiz on 5/14/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation

class CommonRepository {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func downloadImage(_ path: String) -> Future<NSData> {
        let url = URL(string: Paths.ImageURL.rawValue + path)
        return urlSession.downloadImage(url)
    }
    
}
