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
    
    private let service: MoviesListServiceProtocol
    
    private(set) var movies = [Movie]()
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: ResultState = .loading
    private let adult = "false"
    private let video = "false"
    init(service: MoviesListServiceProtocol) {
        self.service = service
    }
    
    func getMovies() {
        self.state = .loading
        
        let cancellable = service
            .getMoviesList(from: .getMoviesList(adult: adult, video: video, sortBy: SortedBy(sortCriteria: .popularity, sortOrder: .descending)))
            .sink { res in
                switch res {
                case .finished:
                    self.state = .success(content: self.movies)
                case .failure(let error):
                    self.state = .failed(error: error)
                }
                
            } receiveValue: { response in
                self.movies = response.movies
            }
        
        self.cancellables.insert(cancellable)
    }
}
