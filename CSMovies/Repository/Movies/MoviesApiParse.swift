//
//  MoviesApiParse.swift
//  CSMovies
//
//  Created by Amanda Calcic on 14/11/22.
//

import Foundation
import SwiftyJSON

public struct MoviesApiParse {
    static func parseNowPlayingMovies(json: JSON) -> NowPlayingMovies {
        var response: NowPlayingMovies = NowPlayingMovies()
        response.page = json["page"].intValue
        response.movies = getMoviesArray(json: json)
        response.totalMovies = json["total_results"].intValue
        response.totalPages = json["total_pages"].intValue
        
        return response
    }
    
    private static func getMoviesArray(json: JSON) -> [Movie] {
        var response: [Movie] = []
        
        if let movies = json["results"].array {
            for movie in movies {
                var movieResponse = Movie()
                movieResponse.idMovie = movie["id"].intValue
                movieResponse.movieTitle = movie["title"].stringValue
                movieResponse.releaseDate = movie["release_date"].stringValue.convertDateToBRFormat()
                movieResponse.overview = movie["overview"].stringValue
                movieResponse.imageUrl = movie["poster_path"].stringValue
                
                response.append(movieResponse)
            }
        }
        
        return response
    }
}
