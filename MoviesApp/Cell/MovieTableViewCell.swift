//
//  MovieTableViewCell.swift
//  MoviesApp
//
//  Created by Rodrigo Vianna on 05/08/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    
    func configure(movie: Movie) {
        titleMovieLabel.text = movie.title
        releaseDateLabel.text = movie.date
        posterImageView.downloadImage(from: movie.poster)
    }
}
