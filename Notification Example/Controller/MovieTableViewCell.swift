//
//  MovieTableViewCell.swift
//  Notification Example
//
//  Created by Eliza Carvalho on 13/11/18.
//  Copyright © 2018 Eliza Carvalho. All rights reserved.
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

    //test
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
        NotificationCenter.default.removeObserver(self)
        self.movie = movie
        
        NotificationCenter.default.addObserver(self, selector: #selector(MovieTableViewCell.imageDownloadedNotificationReceived(_:)), name: Movie.imageDownloadedNotificationName, object: movie)

        titleLabel.text = movie.title
        if let portugueseTitle = movie.portugueseTitle {
            portugueseTitleLabel.isHidden = false
            portugueseTitleLabel.text = portugueseTitle
        } else {
            portugueseTitleLabel.isHidden = true
        }

        if let genre = movie.genre {
            otherDataLabel.text = "\(genre.name)"
        } else {
            otherDataLabel.text = "[Sem gênero]"
        }
        if let year = movie.year {
            otherDataLabel.text = otherDataLabel.text! + " (\(year))"
        }
        if let duration = movie.duration {
            var components = DateComponents()
            components.second = duration
            otherDataLabel.text = otherDataLabel.text! + " – " + MovieTableViewCell.durationFormatter.string(from: components)!
        }

        imdbImageView.image = movie.image
    }
    
    // MARK: - Notifications
    
    @objc private func imageDownloadedNotificationReceived(_ notification: Notification){
        DispatchQueue.main.async {
            self.imdbImageView.image = self.movie?.image
        }
    }
}
