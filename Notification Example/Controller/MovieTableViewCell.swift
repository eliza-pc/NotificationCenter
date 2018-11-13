//
//  MovieTableViewCell.swift
//  Notification Example
//
//  Created by Vilar da Camara Neto on 13/11/18.
//  Copyright © 2018 Vilar da Camara Neto. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    private static let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()

        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        formatter.zeroFormattingBehavior = .dropAll

        return formatter
    }()

    private var movie: Movie? = nil

    @IBOutlet weak var imdbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var portugueseTitleLabel: UILabel!
    @IBOutlet weak var otherDataLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func fill(_ movie: Movie) {
        self.movie = movie

        titleLabel.text = movie.title
        if let portugueseTitle = movie.portugueseTitle {
            portugueseTitleLabel.isHidden = false
            portugueseTitleLabel.text = portugueseTitle
        } else {
            portugueseTitleLabel.isHidden = true
        }

        otherDataLabel.text = "\(movie.genre.name) (\(movie.year))"
        if let duration = movie.duration {
            var components = DateComponents()
            components.second = duration
            otherDataLabel.text = otherDataLabel!.text! + " – " + MovieTableViewCell.durationFormatter.string(from: components)!
        }

        movie.fetchImage { (movie: Movie, image: UIImage) in
            guard movie === self.movie else {
                return
            }
            DispatchQueue.main.async {
                self.imdbImageView.image = image
            }
        }
    }
}
