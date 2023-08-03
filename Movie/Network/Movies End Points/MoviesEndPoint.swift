//
//  MoviesEndPoint.swift
//  Movie
//
//  Created by Marwa Elfeky on 03/08/2023.
//

import Foundation

protocol Request {
    var urlRequest: URLRequest { get }
    var path: String { get }
    var queryItems:[URLQueryItem] {get}
    var baseURL:String {get}

}

enum MoviesEndPoint {
    case getMoviesList(adult:String , video:String ,sortBy:SortedBy)
    case getMoviesListDetails(movieID:String)
}

extension MoviesEndPoint: Request {
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var urlRequest: URLRequest {
        let fullPath = self.baseURL + self.path
        var request = URLRequest(url: (URL(string: fullPath) ?? URL(string: ""))!)
        request.addValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmMzk1OGFkMWQxZTJmNGNhZGNiYjM0ZmVjYzI4OWJkYyIsInN1YiI6IjY0Y2JhMGNlNDNjZDU0MDBlMjdjNzcwZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.G421a3su5p_0RoPjl4VJEkWJ9ftWrkTJvcMIxUjnCOY", forHTTPHeaderField: "Authorization")
        request.addValue("accept", forHTTPHeaderField: "application/json")
        return request
    }
    
    var path: String {
        switch self {
        case .getMoviesList:
            return "discover/movie"
        case .getMoviesListDetails(let movieID):
            return "movie/\(movieID)"
        }
    }
    var queryItems:[URLQueryItem]{
        switch self {
        case .getMoviesList(let adult, let video, let sortBy):
            let items = [URLQueryItem(name: "include_adult", value: adult),
                              URLQueryItem(name: "include_video", value: video) ,
                         URLQueryItem(name: "sort_by", value: sortBy.sortedBy)]
            return items
        case .getMoviesListDetails:
            return []
        }
    }
}
enum SortCriteria:String{
    case popularity = "popularity"
    case revenue = "revenue"
    case releaseDate = "primary_release_date"
    case voteAverage = "vote_avgerage"
    case voteCount = "vote_count"
}
enum SortingOrder:String{
    case ascending = "asc"
    case descending = "desc"
}
struct SortedBy{
    var sortCriteria:SortCriteria
    var sortOrder:SortingOrder
    var sortedBy:String{
        return "\(sortCriteria.rawValue).\(sortOrder.rawValue)"
    }
}
