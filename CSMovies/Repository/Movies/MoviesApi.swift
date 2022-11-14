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
        
        let call = apiRequest.APICall(method: .get, urlPath: "now_playing", parameters: params).map { data in
            return MoviesApiParse.parseNowPlayingMovies(json: data)
        }
        
        return call
    }
}
