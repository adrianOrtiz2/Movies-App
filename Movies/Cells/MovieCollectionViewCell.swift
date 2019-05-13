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
        image.downloadImage(from: viewModel.image)
//        skeleton.startAnimating()
    }
}
