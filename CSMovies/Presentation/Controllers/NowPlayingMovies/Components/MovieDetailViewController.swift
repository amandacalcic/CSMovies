//
//  MovieDetailViewController.swift
//  CSMovies
//
//  Created by Amanda Calcic on 12/12/22.
//

import UIKit

class MovieDetailViewController: UIViewController {
    private var imageData: Data?
    private var movieTitle: String?
    private var overview: String?
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
    
    //MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .lightBackground
    }
    
    func startup(movie: Movie) {
        self.imageData = movie.image
        self.movieTitle = movie.movieTitle
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        
        setupImage()
        setupTitle()
        setupOverview()
        setupReleaseDate()
    }
    
    private func setupImage() {
        guard let imageData = imageData else { return }
        
        movieImageView.image = UIImage(data: imageData)
        
        view.addSubview(movieImageView)
        
        movieImageView.setupAnchor(
            top: (view.topAnchor, 10),
            left: (view.leftAnchor, 10),
            right: (view.rightAnchor, 10),
            height: 400)
    }
    
    private func setupTitle() {
        guard let movieTitle = movieTitle else { return }
        
        titleLabel.text = movieTitle
        
        view.addSubview(titleLabel)
        titleLabel.setupAnchor(
            top: (movieImageView.bottomAnchor, 20),
            left:(view.leftAnchor, 20),
            right: (view.rightAnchor, 20)
        )
    }
    
    private func setupOverview() {
        guard let overview = overview else { return }
        
        overviewLabel.text = overview
        
        view.addSubview(overviewLabel)
        overviewLabel.setupAnchor(
            top: (titleLabel.bottomAnchor, 15),
            left: (view.leftAnchor, 20),
            right: (view.rightAnchor, 20)
        )
    }
    
    private func setupReleaseDate() {
        guard let releaseDate = releaseDate else { return }
        
        releaseDateLabel.text = releaseDate
        
        view.addSubview(titleReleaseDateLabel)
        view.addSubview(releaseDateLabel)
        
        titleReleaseDateLabel.setupAnchor(
            top: (overviewLabel.bottomAnchor, 10),
            left: (view.leftAnchor, 20)
        )
        
        releaseDateLabel.setupAnchor(
            top: (titleReleaseDateLabel.topAnchor, 0),
            left: (titleReleaseDateLabel.rightAnchor, 2)
        )
    }
}
