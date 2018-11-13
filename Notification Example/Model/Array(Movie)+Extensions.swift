//
//  Array(Movie)+Extensions.swift
//  Notification Example
//
//  Created by Vilar da Camara Neto on 13/11/18.
//  Copyright © 2018 Vilar da Camara Neto. All rights reserved.
//

import Foundation


extension Array where Element == Movie {
    func count(ofGenre genre: Movie.Genre) -> Int {
        let moviesOfGenre = self.filter({ (movie: Movie) -> Bool in
            return movie.genre == genre
        })
        return moviesOfGenre.count
    }

    mutating func remove(_ movie: Movie) {
        guard let index = self.firstIndex(where: { $0 === movie }) else {
            return
        }
        self.remove(at: index)
    }
}
