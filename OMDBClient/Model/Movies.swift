//
//  Movies.swift
//  OMDBClient
//
//  Created by Abdul Shamim on 07/02/19.
//  Copyright © 2019 Abdul Shamim. All rights reserved.
//

import Foundation

class MoviesManager {
    static let shared = MoviesManager()
    var selectedMovie: Movie?
}

class Movies {
    var totalResults = 0
    var Response: String?
    var movies = [Movie]()
    
    
    init(json: [String: Any]) {
       
        if let totalResults = json["totalResults"] as? String {
            self.totalResults = Int(totalResults) ?? 0
        }

        if let totalPages = json["Response"] as? String {
            self.Response = totalPages
        }

        if let results = json["Search"] as? [[String: Any]] {
            for result in results {
                let movie = Movie(json: result)
                self.movies.append(movie)
            }
        }
    }
}

class Movie {
    var Title: String?
    var Year: String?
    var imdbID: String?
    var `Type`: String?
    var Poster: String?
    
    init(json: [String: Any]) {
        if let title = json["Title"] as? String {
            self.Title = title
        }
        
        if let year = json["Year"] as? String {
            print(year)
            print(String(year.prefix(4)).timeAgo())
            self.Year = String(year.prefix(4)).timeAgo()
        }

        if let poster = json["Poster"] as? String {
            self.Poster = poster
        }
        
        if let type = json["Type"] as? String {
            self.Type = type
        }
    }
}


