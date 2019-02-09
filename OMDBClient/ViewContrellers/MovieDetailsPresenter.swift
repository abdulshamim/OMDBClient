//
//  MovieDetailsPresenter.swift
//  OMDBClient
//
//  Created by Abdul Shamim on 08/02/19.
//  Copyright © 2019 Abdul Shamim. All rights reserved.
//

import Foundation

class MovieDetailsPresenter: NSObject {
    
    weak var movieDetailsController: MovieDetailsController?
    
    
    init(viewController: MovieDetailsController) {
        super.init()
        self.movieDetailsController = viewController
    }
    
    func setView(vc: MovieDetailsController) {
        if #available(iOS 11.0, *) {
            vc.navigationController?.navigationBar.prefersLargeTitles = false
        } else {
        }
        vc.title = MoviesManager.shared.selectedMovie?.Title
        movieDetailsController?.tableView.dataSource = movieDetailsController
        movieDetailsController?.tableView.separatorStyle = .none
        movieDetailsController?.tableView.estimatedRowHeight = 550
    }
}
