//
//  MovieStatisticsViewController.swift
//  Notification Example
//
//  Created by Vilar da Camara Neto on 13/11/18.
//  Copyright © 2018 Vilar da Camara Neto. All rights reserved.
//

import UIKit

class MovieStatisticsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Movie.Genre.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieStatistics", for: indexPath)
        let genre = Movie.Genre(rawValue: indexPath.row)!
        let genreCount = allMovies.count(ofGenre: genre)

        cell.textLabel?.text = genre.name
        cell.detailTextLabel?.text = "\(genreCount)"

        return cell
    }
}
