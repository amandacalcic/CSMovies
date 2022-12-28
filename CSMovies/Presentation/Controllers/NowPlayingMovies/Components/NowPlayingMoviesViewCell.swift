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
    private var releaseDate: String?
    
    private lazy var movieImageView: UIImageView = {
        var image = UIImageView()
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .darkTextColor
        return label
    }()
    
    private lazy var titleReleaseDateLabel: UILabel = {
        var label = UILabel()
        label.text = "Lançamento: "
        label.font = .systemFont(ofSize: 13)
        label.textColor = .darkTextColor
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .darkTextColor
        return label
    }()
    
    func setup(movie: Movie) {
        self.imageData = movie.image
        self.title = movie.movieTitle
        self.releaseDate = movie.releaseDate
        
        contentView.backgroundColor = .lightBackground
        
        setupImage()
        setupTitle()
        setupReleaseDate()
    }
    
    private func setupImage() {
        guard let imageData = imageData else { return }
        
        movieImageView.image = UIImage(data: imageData)
        
        contentView.addSubview(movieImageView)
        
        movieImageView.setupAnchor(
            top: (contentView.topAnchor, 20),
            left: (contentView.leftAnchor, 20),
            bottom: (contentView.bottomAnchor, 20),
            width: 130,
            height: 100)
    }
    
    private func setupTitle() {
        guard let title = title else { return }
        
        titleLabel.text = title
        
        contentView.addSubview(titleLabel)
        titleLabel.setupAnchor(
            top: (movieImageView.topAnchor, 10),
            left:(movieImageView.rightAnchor, 10),
            right: (contentView.rightAnchor, 20)
        )
    }
    
    private func setupReleaseDate() {
        guard let releaseDate = releaseDate else { return }
        
        releaseDateLabel.text = releaseDate
        
        contentView.addSubview(titleReleaseDateLabel)
        contentView.addSubview(releaseDateLabel)
        
        titleReleaseDateLabel.setupAnchor(
            top: (titleLabel.bottomAnchor, 5),
            left: (titleLabel.leftAnchor, 0)
        )
        
        releaseDateLabel.setupAnchor(
            top: (titleReleaseDateLabel.topAnchor, 0),
            left: (titleReleaseDateLabel.rightAnchor, 2)
        )
    }
}
