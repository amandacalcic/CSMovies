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
    func getNowPlayingMovies() -> Observable<Void>
}

class NowPlayingMoviesViewModel: NowPlayingMoviesViewModelProtocol {
    private let repository: MoviesApiProtocol
    
    internal var movies: [Movie] = []
    private var currentPage: Int = 1
    
    init(repository: MoviesApiProtocol = MoviesApi()) {
        self.repository = repository
    }
    
    func getNowPlayingMovies() -> Observable<Void> {
        return repository.getNowPlayingMovies(page: currentPage).map { [weak self] result in
            guard let self = self else { return }
            self.movies = result.movies
        }
    }
    
    
    
}
