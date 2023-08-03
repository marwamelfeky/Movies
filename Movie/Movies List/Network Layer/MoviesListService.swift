//
//  MoviesAPI.swift
//  Movie
//
//  Created by Marwa Elfeky on 03/08/2023.
//

import Foundation
import Combine

protocol MoviesServiceProtocol {
    func getMoviesList(from endpoint: MoviesEndPoint) -> AnyPublisher<MoviesList, APIError>
}

struct MoviesListService:  MoviesServiceProtocol {
    
    func getMoviesList(from endpoint: MoviesEndPoint) -> AnyPublisher<MoviesList, APIError> {
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.unknown}
            .flatMap { data, response -> AnyPublisher<MoviesList, APIError> in
                
                guard let response = response as? HTTPURLResponse else {
                    print("Error")
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                if (200...299).contains(response.statusCode) {
                    print("response status code \(response.statusCode) of \(endpoint.path)")
                    let jsonDecoder = JSONDecoder()
                    let str = String(decoding: data, as: UTF8.self)
                    print("Data of \(endpoint.path ) is \(str)")

                    print(str)
                    print(Just(data)
                        .decode(type: MoviesList.self , decoder: jsonDecoder)
                        .mapError { _ in APIError.decodingError }
                        .eraseToAnyPublisher().values)
                    return Just(data)
                        .decode(type: MoviesList.self , decoder: jsonDecoder)
                        .mapError { _ in APIError.decodingError }
                        .eraseToAnyPublisher()
                } else {
                    print("MoviesServiceImpl Failes")
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
                
            }
            .eraseToAnyPublisher()
    }
    
}
