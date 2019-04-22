//
//  MovieStatisticsViewController.swift
//  Notification Example
//
//  Created by Eliza Carvalho on 13/11/18.
//  Copyright © 2018 Eliza Carvalho. All rights reserved.
//

import UIKit

class MovieStatisticsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         NotificationCenter.default.addObserver(self, selector: #selector(MovieStatisticsViewController.moviesChangedNotificationReceived(_:)), name: Movie.moviesChangedNotification, object: nil)
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Movie.Genre.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieStatistics", for: indexPath)
        let genre = Movie.Genre(rawValue: indexPath.row)
        let genreCount = allMovies.count(ofGenre: genre)

        cell.textLabel?.text = genre?.name ?? "(Sem gênero)"
        cell.detailTextLabel?.text = "\(genreCount)"

        return cell
    }
    @objc private func moviesChangedNotificationReceived(_ notification: Notification){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
