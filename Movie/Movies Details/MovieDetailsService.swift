//
//  MovieDetailsService.swift
//  Movie
//
//  Created by Marwa Elfeky on 03/08/2023.
//

import UIKit
import Combine
protocol MovieDetailsServiceProtocol {
    func getMovieDetails(from endpoint: MoviesEndPoint) -> AnyPublisher<Movie, APIError>
}

struct MovieDetailsService:  MovieDetailsServiceProtocol {
    
    func getMovieDetails(from endpoint: MoviesEndPoint) -> AnyPublisher<Movie, APIError> {
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.unknown}
            .flatMap { data, response -> AnyPublisher<Movie, APIError> in
                
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                if (200...299).contains(response.statusCode) {
                    print("response status code \(response.statusCode) of \(endpoint.path)")
                    let jsonDecoder = JSONDecoder()
                    let str = String(decoding: data, as: UTF8.self)
                    print("Data of \(endpoint.path ) is \(str)")
                    return Just(data)
                        .decode(type: Movie.self , decoder: jsonDecoder)
                        .mapError { _ in APIError.decodingError }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
                
            }
            .eraseToAnyPublisher()
    }
    
}

