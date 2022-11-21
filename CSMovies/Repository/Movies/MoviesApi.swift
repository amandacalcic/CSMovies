//
//  MoviesApi.swift
//  CSMovies
//
//  Created by Amanda Calcic on 14/11/22.
//

import Foundation
import RxSwift

protocol MoviesApiProtocol: AnyObject {
    func getNowPlayingMovies(page: Int) -> Observable<NowPlayingMovies>
}

class MoviesApi: MoviesApiProtocol {
    private let language: String = "pt-BR"
    private let apiRequest = ApiRequest()
    
    public func getNowPlayingMovies(page: Int) -> Observable<NowPlayingMovies> {
        let params: [String: String] = [
            "language": language,
            "page": String(page)
        ]
        
        let call = apiRequest.ApiRequest(method: .get, urlPath: "now_playing", parameters: params).flatMap { [weak self] data -> Observable<NowPlayingMovies> in
            guard let self = self else { return Observable.empty() }
            let json = self.apiRequest.convertDataToJSON(with: data)
            return Observable.just(MoviesApiParse.parseNowPlayingMovies(json: json))
        }
        
        return call
    }
}
