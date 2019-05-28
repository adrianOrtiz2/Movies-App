//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Adrian Ortiz on 3/27/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell, NibLodableView, ReusableView  {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var skeleton: SkeletonView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(with viewModel: MovieCellViewModel) {
        movieTitle.text = viewModel.title
        duration.text = viewModel.releaseDate
        viewModel.downloadImage().decodeImage().observe { [weak self] (result) in
            switch result {
            case .success(let img):
                self?.image.image = img
            case .failure:
                self?.image.image = UIImage(named: "broken")
            }
        }
//        skeleton.startAnimating()
    }
}
