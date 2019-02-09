//
//  MoviesCollectionCell.swift
//  OMDBClient
//
//  Created by Abdul Shamim on 08/02/19.
//  Copyright © 2019 Abdul Shamim. All rights reserved.
//

import UIKit

class MoviesCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var roundCornerView: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var relasingDateLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
    }
    
    func setUpData(result: Movie?) {
        if let result = result {
            self.titleLabel.text = result.Title  ?? ""
            self.relasingDateLabel.text = "Release Date: " + (result.Year ?? "")
             self.typeLabel.text = "Type: " + (result.Type ?? "")
            let imagePath = result.Poster ?? ""
            self.posterImage.contentMode = .scaleToFill
            self.posterImage.kf.indicatorType = .activity
            self.posterImage.kf.setImage(with: URL(string: imagePath)!, placeholder: nil)
        }
        self.setBgView()
    }
    
    func setBgView() {
        self.roundCornerView.layer.cornerRadius = 5
        self.layer.masksToBounds = false
        self.roundCornerView.clipsToBounds = true
    }
}
