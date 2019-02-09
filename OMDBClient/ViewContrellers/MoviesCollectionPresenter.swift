//
//  MoviesCollectionPresenter.swift
//  OMDBClient
//
//  Created by Abdul Shamim on 07/02/19.
//  Copyright © 2019 Abdul Shamim. All rights reserved.
//

import UIKit

class MoviesCollectionPresenter: NSObject {
    
    var moviesObject: Movies?
    var movies = [Movie]()
    var pageCount = 1
    
    weak var moviesCollectionController: MoviesCollectionController?
    
    override init() {
    }
    
    init(viewController: MoviesCollectionController) {
        super.init()
    }
    

    
    // MARK : SetUp Naviation controller
    func setUpNavigationBar(vc: MoviesCollectionController) {
        vc.title = "Movies"
        if #available(iOS 11.0, *) {
            vc.navigationController?.navigationBar.prefersLargeTitles = true
            vc.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        } else {
            // Fallback on earlier versions
        }
        
        vc.navigationController?.navigationBar.barTintColor = UIColor.red
        vc.navigationController?.navigationBar.tintColor = .white
        vc.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    
    func setCollectionBackgroundView(_ frame: CGRect) -> UIView {
        let backgroundView = UIView()
        backgroundView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        let label = UILabel(frame: CGRect(x: 0, y: frame.height/2 - 100, width: frame.width, height: 60))
        label.text = "No movies found"
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        backgroundView.addSubview(label)
        return backgroundView
    }
    
    func isPaginationActive(callBack : @escaping (_ isActive: Bool) -> Void) {
        guard let moviesObject = moviesObject else {
            callBack(false)
            return
        }
        if self.movies.count < moviesObject.totalResults {
            callBack(true)
        }
        callBack(false)
    }
    
    // MARK : Get movies from tmdb server
    func getMovies(pageCount: Int, callBack : @escaping (_ isSuccess: Bool) -> Void) {
        let path = API.baseUrl + "&page=\(pageCount)&apikey=eeefc96f"
        print(path)
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        NetworkingClass(path: path,
                        method: .get)
            .config(activityIndicatorEnable: false)
            .connectServerWithoutImage(delay: 0){(_ response: Any?, data: Data?, error: Error?) in
                
                guard let response = response as? [String: Any] else {
                    callBack(false)
                    return
                }
                
                self.moviesObject = Movies(json: response)
                for movie in self.moviesObject?.movies ?? [] {
                    self.movies.append(movie)
                }
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                
                callBack(true)
        }
        
    }
}
