//
//  MoviesViewController.swift
//  MoviesApp
//
//  Created by Rodrigo Vianna on 08/08/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit

fileprivate let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)

class MoviesViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let moviePresenter = MoviePresenter(movieService: MovieRequester())
    private var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.register(nib, forCellReuseIdentifier: "movie")
        moviesTableView.dataSource = self
        moviePresenter.attachView(view: self)
        moviePresenter.getMovies()
        activityIndicator.hidesWhenStopped = true
    }
}

extension MoviesViewController: MovieView {
    func startLoading() {
        activityIndicator.startAnimating()
        self.view.bringSubview(toFront: activityIndicator)
    }
    
    func finishLoading() {
        activityIndicator.stopAnimating()
    }
    
    func setMovies(movies: [Movie]) {
        self.movies = movies
        moviesTableView.reloadData()
        finishLoading()
    }
    
    func setEmptyMovies() {
        moviesTableView.isHidden = true
    }
}

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movie", for: indexPath) as! MovieTableViewCell
        cell.configure(movie: movies[indexPath.row])
        return cell
    }
}
