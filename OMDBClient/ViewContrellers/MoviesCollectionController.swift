//
//  MoviesCollectionController.swift
//  OMDBClient
//
//  Created by Abdul Shamim on 07/02/19.
//  Copyright © 2019 Abdul Shamim. All rights reserved.
//

import UIKit

class MoviesCollectionController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: MoviesCollectionPresenter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MoviesCollectionPresenter(viewController: self)
        self.getMovies(page: presenter?.pageCount ?? 1)
        self.setUp()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.setUpNavigationBar(vc: self)
    }
    
    //MARK :- Set collection view background if no movie result is coming from server
    fileprivate func setCollectionbackgroundOnNoDataFromServer() {
        if self.presenter?.movies.count == 0 {
            self.collectionView.backgroundView = self.presenter?.setCollectionBackgroundView(self.collectionView.frame)
        } else {
            self.collectionView.backgroundView = nil
        }
    }
    
    //MARK :- Get Movies list from server
    func getMovies(page: Int) {
        presenter?.getMovies(pageCount: page) {[weak self] (isSuccess: Bool) in
            if isSuccess {
                DispatchQueue.main.async {
                    self?.setCollectionbackgroundOnNoDataFromServer()
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: Register collection nib cell and setup UI
    func setUp() {
        //collectionView?.backgroundColor = .clear
       
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        collectionView.register(UINib(nibName: Identifier.moviesCollectionCell, bundle: Bundle.main), forCellWithReuseIdentifier: Identifier.moviesCollectionCell)
    }
}

// MARK : Collection Delegates and Data Source
extension MoviesCollectionController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.movies.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.moviesCollectionCell, for: indexPath as IndexPath) as? MoviesCollectionCell else {
            fatalError("Constant.Message.cellNotFound")
        }
        cell.setUpData(result: presenter?.movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Identifier.movieDetailsController) as? MovieDetailsController
        MoviesManager.shared.selectedMovie = presenter?.movies[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        flowLayout?.minimumInteritemSpacing = 2
        flowLayout?.minimumLineSpacing = 2

         let width = (UIScreen.main.bounds.width - 14) / 2
        return CGSize(width: width, height: width + 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastRowIndex = collectionView.numberOfItems(inSection: 0) - 1
        if indexPath.row == lastRowIndex {
            guard let presenter = presenter  else {
                return
            }
            presenter.isPaginationActive { [weak self] (isActive: Bool) in
                if isActive {
                    presenter.pageCount += 1
                    self?.getMovies(page: presenter.pageCount)
                }
            }
            
        }
    }

}
