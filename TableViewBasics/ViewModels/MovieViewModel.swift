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
    // All movies array
    var movies: [Movie] = []
    // Default movies array
    private let defaultMovies = ["Eternals", "Dune", "No Time To Die", "Last Night in Soho", "Ron’s Done Wrong", "Halloween Kills", "Venom", "Antlers", "The Addams Family 2"]
    // Sorted movies array
    private var sortedMovies: [Movie] {
        return movies.sorted { $0.movieName < $1.movieName }
    }
    
    // Init method to add default movies and sort them
    init() {
        for movie in defaultMovies {
            movies.append(Movie(movieName: movie))
        }
        self.movies = sortedMovies
    }
    
    // A mutating function that adds movie to movies array
    // Parameters: movie - a Movie object
    mutating func addMovie(movie: Movie) {
        self.movies.append(movie)
    }
}
