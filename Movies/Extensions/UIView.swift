//
//  UIView.swift
//  Movies
//
//  Created by Adrian Ortiz on 4/8/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func downloadImage(from url: String) {
        let imageCache = NSCache<NSString, UIImage>()
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            self.image = cachedImage
            return
        }
        URLSession.shared.dataTask(with: NSURLRequest(url: URL(string: "https://image.tmdb.org/t/p/w500/\(url)")!) as URLRequest) { (data, _, error) in
            DispatchQueue.main.async() { () -> Void in
                guard let data = data, error == nil else {
                    self.image = UIImage(named: "avatar")
                    return
                }
                if let img = UIImage(data: data) {
                    self.image = img
                }
            }
        }.resume()
    }
    
}
