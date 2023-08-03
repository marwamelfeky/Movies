//
//  ResultState.swift
//  Movie
//
//  Created by Marwa Elfeky on 03/08/2023.
//

import Foundation
enum ResultState {
    case success(content: [Movie])
    case successDetails(content: Movie)
    case failed(error: Error)
}
