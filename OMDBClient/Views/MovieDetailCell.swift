//
//  MovieDetailCell.swift
//  OMDBClient
//
//  Created by Abdul Shamim on 08/02/19.
//  Copyright © 2019 Abdul Shamim. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setUpData(movie: Movie?) {
        if let movie = movie {
            self.movieTitleLabel.text = movie.Title ?? ""
            self.releaseDateLabel.text = "Release Date: " + (movie.Year ?? "")
            self.overviewLabel.text = "Type: " + (movie.Type ?? "")
            self.posterImage.contentMode = .scaleToFill
            self.posterImage.kf.indicatorType = .activity
            self.posterImage.kf.setImage(with: URL(string: movie.Poster ?? "")!, placeholder: nil)
        }
    }
}
