//
//  MoviesDetailsViewModel.swift
//  Movie
//
//  Created by Marwa Elfeky on 03/08/2023.
//

import UIKit
import Combine

protocol MoviesDetailsViewModelProtocol {
    func getMovieDetails(id:Int)
}
class MoviesDetailsViewModel: ObservableObject, MoviesDetailsViewModelProtocol {
    
    private let service: MovieDetailsServiceProtocol
    
    private(set) var movie = Movie()
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: ResultState = .loading
    
    init(service: MovieDetailsServiceProtocol) {
        self.service = service
    }
    
    func getMovieDetails(id:Int){
        self.state = .loading
        
        let cancellable = service
            .getMovieDetails(from: .getMoviesListDetails(movieID: id))
            .sink { res in
                print("Result in view model")
                print(res)
                switch res {
                case .finished:
                    // send back the articles
                    self.state = .successDetails(content: self.movie)
                    print("Finished")
                case .failure(let error):
                    // send back the error
                    print("Failure \(error)")
                    self.state = .failed(error: error)
                }
                
            } receiveValue: { response in
                self.movie = response
            }
        
        self.cancellables.insert(cancellable)
    }
}
