//
//  MovieEditViewController.swift
//  Notification Example
//
//  Created by Vilar da Camara Neto on 13/11/18.
//  Copyright © 2018 Vilar da Camara Neto. All rights reserved.
//

import UIKit

class MovieEditViewController: UIViewController {
    var movie: Movie?

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var portugueseTitleText: UITextField!
    @IBOutlet weak var durationText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var deleteButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleText.text = movie?.title
        portugueseTitleText.text = movie?.portugueseTitle
        if let duration = movie?.duration {
            durationText.text = "\(duration)"
        } else {
            durationText.text = nil
        }
        if let year = movie?.year {
            yearText.text = "\(year)"
        } else {
            yearText.text = nil
        }

        deleteButton.isHidden = (movie == nil)
    }

    // MARK: - Actions

    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {

        navigationController?.popViewController(animated: true)
    }

    @IBAction func deleteButtonClicked(_ sender: Any) {
        if let movie = movie {
            allMovies.remove(movie)
            navigationController?.popViewController(animated: true)
        }
    }
}
