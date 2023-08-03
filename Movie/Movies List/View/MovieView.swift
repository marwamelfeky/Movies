//
//  MoviesView.swift
//  Movie
//
//  Created by Marwa Elfeky on 03/08/2023.
//

import SwiftUI

import URLImage

struct MovieView: View {
    
    let movie: Movie
    private let imageWidth = 100.0
    private let imageHeight = 150.0
    private let stackSpacing = 4.0
    var body: some View {
        HStack(alignment: .top, spacing:4) {
            let imgUrl = movie.image
            if
               let url = URL(string: imgUrl) {
                
                URLImage(url) { image in
                    image
                        .resizable()
                        .frame(width:imageWidth , height: imageHeight).cornerRadius(5.0)
                }
            } else {
                PlaceholderImageView()
            }
            
            VStack(alignment: .leading, spacing: stackSpacing) {
                Text(movie.title ?? "")
                    .foregroundColor(.black)
                    .font(.headline)
                Text(movie.year)
                    .foregroundColor(.black)
                    .font(.footnote)
            }
        }.padding(EdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0))
    }
}

struct PlaceholderImageView: View {
    var body: some View {
        Image(systemName: "photo.fill")
            .foregroundColor(.white)
            .background(Color.white)
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: Movie())
            .previewLayout(.sizeThatFits )
    }
}
