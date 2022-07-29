//
//  MovieViewModel.swift
//  TableViewBasics
//
//  Created by Aman on 28/07/22.
//

import Foundation
import UIKit
import UniformTypeIdentifiers

struct MovieViewModel {
    
    var movies: [Movie] = []
    private let defaultMovies = ["Eternals", "Dune", "No Time To Die", "Last Night in Soho", "Ron’s Done Wrong", "Halloween Kills", "Venom", "Antlers", "The Addams Family 2"]
    private var sortedMovies: [Movie] {
        return movies.sorted { $0.movieName < $1.movieName }
    }
    
    init() {
        for movie in defaultMovies {
            movies.append(Movie(movieName: movie))
        }
        self.movies = sortedMovies
    }
    
    mutating func addMovie(movie: Movie) {
        self.movies.append(movie)
    }
}
