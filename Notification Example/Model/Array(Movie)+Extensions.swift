//
//  Array(Movie)+Extensions.swift
//  Notification Example
//
//  Created by Vilar da Camara Neto on 13/11/18.
//  Copyright © 2018 Vilar da Camara Neto. All rights reserved.
//

import Foundation


extension Array where Element == Movie {
    func count(ofGenre genre: Movie.Genre?) -> Int {
        let moviesOfGenre = self.filter({ (movie: Movie) -> Bool in
            return movie.genre == genre
        })
        return moviesOfGenre.count
    }

    func insertionIndex(of movie: Movie) -> Int {
        var lo = 0
        var hi = self.count - 1

        while lo <= hi {
            let mid = (lo + hi) / 2
            if self[mid].title.localizedCaseInsensitiveCompare(movie.title) == .orderedAscending {
                lo = mid + 1
            } else if movie.title.localizedCaseInsensitiveCompare(self[mid].title) == .orderedAscending {
                hi = mid - 1
            } else {
                return mid
            }
        }

        return lo
    }

    mutating func add(_ movie: Movie) {
        let index = insertionIndex(of: movie)
        self.insert(movie, at: index)
    }

    mutating func remove(_ movie: Movie) {
        guard let index = self.firstIndex(where: { $0 === movie }) else {
            return
        }
        self.remove(at: index)
    }

    mutating func update(_ movie: Movie) {
        remove(movie)
        add(movie)
    }
}
