//
//  NowPlayingMoviesViewCell.swift
//  CSMovies
//
//  Created by Amanda Calcic on 16/11/22.
//

import UIKit

class NowPlayingMoviesViewCell: UITableViewCell {
    static let identifier = "nowPlayingMoviesCell"
    
    private var imageData: Data?
    private var title: String?
    private var overview: String?
    private var releaseDate: String?
    
    private lazy var movieImageView: UIImageView = {
        var image = UIImageView()
        image.layer.cornerRadius = 15
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .darkTextColor
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.sizeToFit()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .darkTextColor
        return label
    }()
    
    private lazy var titleReleaseDateLabel: UILabel = {
        var label = UILabel()
        label.text = "Lançamento: "
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkTextColor
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkTextColor
        return label
    }()
    
    func setup(movie: Movie) {
        self.imageData = movie.image
        self.title = movie.movieTitle
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        
        contentView.backgroundColor = .lightBackground
        
        setupImage()
        setupTitle()
        setupOverview()
        setupReleaseDate()
    }
    
    private func setupImage() {
        guard let imageData = imageData else { return }
        
        movieImageView.image = UIImage(data: imageData)
        
        contentView.addSubview(movieImageView)
        
        movieImageView.setupAnchor(
            top: (contentView.topAnchor, 20),
            left: (contentView.leftAnchor, 20),
            right: (contentView.rightAnchor, 20),
            height: 400)
    }
    
    private func setupTitle() {
        guard let title = title else { return }
        
        titleLabel.text = title
        
        let topAnchorTitle = imageData != nil ? movieImageView.bottomAnchor : contentView.topAnchor
        
        contentView.addSubview(titleLabel)
        titleLabel.setupAnchor(
            top: (topAnchorTitle, 20),
            left:(contentView.leftAnchor, 20),
            right: (contentView.rightAnchor, 20)
        )
    }
    
    private func setupOverview() {
        guard let overview = overview else { return }
        
        overviewLabel.text = overview
        
        contentView.addSubview(overviewLabel)
        overviewLabel.setupAnchor(
            top: (titleLabel.bottomAnchor, 15),
            left: (contentView.leftAnchor, 20),
            right: (contentView.rightAnchor, 20)
        )
    }
    
    private func setupReleaseDate() {
        guard let releaseDate = releaseDate else { return }
        
        releaseDateLabel.text = releaseDate
        
        contentView.addSubview(titleReleaseDateLabel)
        contentView.addSubview(releaseDateLabel)
        
        titleReleaseDateLabel.setupAnchor(
            top: (overviewLabel.bottomAnchor, 10),
            left: (contentView.leftAnchor, 20),
            bottom: (contentView.bottomAnchor, 20)
        )
        
        releaseDateLabel.setupAnchor(
            top: (titleReleaseDateLabel.topAnchor, 0),
            left: (titleReleaseDateLabel.rightAnchor, 2),
            bottom: (titleReleaseDateLabel.bottomAnchor, 0)
        )
    }
}
