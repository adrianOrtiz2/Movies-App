//
//  PageIntroViewController.swift
//  Movies
//
//  Created by Adrian Ortiz on 3/26/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import UIKit

protocol PageDelegate {
    func exploreCollectionPressed()
}

class PageIntroViewController: UIViewController {
    
    var delegate: PageDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func exploreCollection(_ sender: Any) {
        delegate?.exploreCollectionPressed()
    }

}
