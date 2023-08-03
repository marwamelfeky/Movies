//
//  MoviesListViewModel.swift
//  Movie
//
//  Created by Marwa Elfeky on 03/08/2023.
//

import UIKit
import Combine

protocol MoviesListViewModelProtocol {
    func getMovies()
}

class MoviesListViewModel: ObservableObject, MoviesListViewModelProtocol {
    
    private let service: MoviesServiceProtocol
    
    private(set) var movies = [Movie]()
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: ResultState = .loading
    
    init(service: MoviesServiceProtocol) {
        self.service = service
    }
    
    func getMovies() {
        self.state = .loading
        
        let cancellable = service
            .request(from: .getMoviesList(adult: "false", video: "false", sortBy: SortedBy(sortCriteria: .popularity, sortOrder: .descending)))
            .sink { res in
                print("Result in view model")
                print(res)
                switch res {
                case .finished:
                    // send back the articles
                    self.state = .success(content: self.movies)
                    print("Finished")
                case .failure(let error):
                    // send back the error
                    print("Failure \(error)")
                    self.state = .failed(error: error)
                }
                
            } receiveValue: { response in
                self.movies = response.movies
            }
        
        self.cancellables.insert(cancellable)
    }
}
