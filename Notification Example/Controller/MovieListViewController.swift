//
//  MovieListViewController.swift
//  Notification Example
//
//  Created by Vilar da Camara Neto on 13/11/18.
//  Copyright © 2018 Vilar da Camara Neto. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieEditViewController = segue.destination as? MovieEditViewController {
            guard let indexPath = tableView.indexPathForSelectedRow else {
                // Nenhum item selecionado:
                movieEditViewController.movie = nil
                return
            }
            let movie = allMovies[indexPath.row]

            movieEditViewController.movie = movie
        }
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Movie", for: indexPath) as! MovieTableViewCell
        let movie = allMovies[indexPath.row]

        cell.fill(movie)

        return cell
    }

    // MARK: - Actions

    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        tableView.selectRow(at: nil, animated: false, scrollPosition: .none)
        performSegue(withIdentifier: "EditMovie", sender: nil)
    }
}
