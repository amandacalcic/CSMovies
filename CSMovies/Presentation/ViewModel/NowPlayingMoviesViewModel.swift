//
//  NowPlayingMoviesViewModel.swift
//  CSMovies
//
//  Created by Amanda Calcic on 14/11/22.
//

import Foundation
import RxSwift

protocol NowPlayingMoviesViewModelProtocol {
    var movies: [Movie] { get }
    var currentPage: Int { get set }
    func getNowPlayingMovies() -> Observable<Void>
}

class NowPlayingMoviesViewModel: NowPlayingMoviesViewModelProtocol {
    private let repository: MoviesApiProtocol
    private let imageRepository: ImageApiProtocol
    private let disposeBag = DisposeBag()
    
    private var movieResult = NowPlayingMovies()
    internal var movies: [Movie] = []
    internal var currentPage: Int = 1
    
    init(repository: MoviesApiProtocol = MoviesApi(),
         imageRepository: ImageApiProtocol = ImageApi()) {
        self.repository = repository
        self.imageRepository = imageRepository
    }
    
    func getNowPlayingMovies() -> Observable<Void> {
        return repository.getNowPlayingMovies(page: currentPage)
            .flatMap { [weak self] result -> Observable<[Movie]> in
                guard let self = self else { return Observable.empty() }
                self.movieResult = result
                self.currentPage = result.page
                return self.getSortedMovies(movies: result.movies)
            }.map { [weak self] movies in
                guard let self = self else { return }
                self.movies = movies
            }
    }
    
    private func getSortedMovies(movies: [Movie]) -> Observable<[Movie]> {
        return Observable.from(movies)
            .concatMap { [weak self] movie -> Observable<Movie> in
                guard let self = self else {return Observable.empty() }
                return self.getImageFromURL(movie: movie)
            }.toArray()
            .flatMap { [weak self] movies -> Single<[Movie]> in
                guard let _ = self else {return Single.just([]) }
                let sortedMovies = movies.sorted(by: { $0.releaseDate!.convertToDate() > $1.releaseDate!.convertToDate() })
                return Single.just(sortedMovies)
            }.asObservable()
    }
    
    private func getImageFromURL(movie: Movie) -> Observable<Movie> {
        guard let imageUrl = movie.imageUrl else { return Observable.empty() }
        return imageRepository.getImageFromURL(with: imageUrl)
            .flatMap { image -> Observable<Movie> in
                var currentMovie = movie
                currentMovie.image = image
                return Observable.just(currentMovie)
            }
    }
}
