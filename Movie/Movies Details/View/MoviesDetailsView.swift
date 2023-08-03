//
//  MoviesDetailsView.swift
//  Movie
//
//  Created by Marwa Elfeky on 03/08/2023.
//

import SwiftUI
import URLImage
struct MoviesDetailsView: View {
    let movie: Movie
    private let imageWidth = 150.0
    private let imageHeight = 300.0
    @StateObject var viewModel = MoviesDetailsViewModel(service: MovieDetailsService())

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(alignment: .center, spacing: 10) {
                let imgUrl = movie.image
                if
                    let url = URL(string: imgUrl) {
                    
                    URLImage(url) { image in
                        image
                            .resizable().frame(width: imageWidth , height: imageHeight).cornerRadius(5.0)
                    }
                } else {
                    PlaceholderImageView()
                }
               
                Text(movie.title ?? "")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .semibold))  .frame(maxWidth: .infinity, alignment: .leading)
                Text(movie.overview ?? "")
                    .foregroundColor(.black)
                    .font(.footnote).frame(maxWidth: .infinity, alignment: .leading)
            }}.onAppear{
            self.viewModel.getMovieDetails(id: movie.id)
        }.padding(EdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0))
    }
}

struct MoviesDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesDetailsView(movie: Movie())
    }
}
