//
//  MoviesList.swift
//  Movie
//
//  Created by Marwa Elfeky on 03/08/2023.
//

import Foundation
struct MoviesList: Codable {
    let movies: [Movie]
    let page:Int
    enum CodingKeys: String, CodingKey {
        case movies = "results"
        case page
    }
}

// MARK: - Article
struct Movie: Codable , Identifiable {
    var id: Int
    let title: String?
    let date: String?
    var poster: String?
    var overview:String?
    var image:String{
        return "https://image.tmdb.org/t/p/w500" + (self.poster ?? "")
    }
    var year:String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self.date ?? ""){
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year], from: date)
            let year = components.year
            return "\(year ?? 2023)"
        }
        return self.date ?? ""
        
        
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case date = "release_date"
        case poster = "poster_path"
        case overview
    }
    init(){
        self.id = 0
        self.title = ""
        self.date = ""
        self.poster = ""
        self.overview = ""
    }
}

