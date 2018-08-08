//
//  MoviePresenter.swift
//  MoviesApp
//
//  Created by Rodrigo Vianna on 08/08/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//


protocol MovieView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setMovies(movies: [Movie])
    func setEmptyMovies()
    
}

import UIKit

class MoviePresenter {
    private let movieService: MovieRequester
    weak private var movieView: MovieView?
    
    init(movieService: MovieRequester) {
        self.movieService = movieService
    }
    
    func attachView(view: MovieView) {
        movieView = view
    }
    
    func detachView() {
        movieView = nil
    }
    
    func getMovies() {
        self.movieView?.startLoading()
        movieService.getPopularMovies { [weak self] (result) in
            switch result {
            case .failure( _):
                self?.movieView?.setEmptyMovies()
            case .success(let data):
                if data.isEmpty {
                    self?.movieView?.setEmptyMovies()
                } else {
                    let movies = data.compactMap {
                        return Movie(title: $0.title, date: $0.date, poster: $0.poster)
                    }
                    self?.movieView?.setMovies(movies: movies)
                }
            }
        }
    }
}
