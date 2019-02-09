//
//  Constant.swift
//  OMDBClient
//
//  Created by Abdul Shamim on 07/02/19.
//  Copyright © 2019 Abdul Shamim. All rights reserved.
//

import Foundation


struct API {
    static let baseUrl = "http://www.omdbapi.com/?s=Batman"
}

struct Identifier {
    static let moviesCollectionCell = "MoviesCollectionCell"
    static let movieDetailsController = "MovieDetailsController"
    
    static let movieDetailCell = "MovieDetailCell"
}

struct DateFormatters {
    static let serverDateFormat = "yyyy"
    static let displayDateFormat = "yyyy"
}
