//
//  MoviesView.swift
//  Movie
//
//  Created by Marwa Elfeky on 03/08/2023.
//

import SwiftUI

import URLImage

struct MoviesView: View {
    
    let movie: Movie
    
    var body: some View {
        HStack {
            if let imgUrl = movie.poster,
               let url = URL(string: imgUrl) {
                
                URLImage(url: url,
                         options: URLImageOptions(
                            identifier: movie.id,
                            cachePolicy: .returnCacheElseLoad(cacheDelay: nil, downloadDelay: 0.25)
                         ),
                         failure: { error, _ in
                    PlaceholderImageView()
                },
                         content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                })
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            } else {
                PlaceholderImageView()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title ?? "")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold))
                Text(movie.date ?? "N/A")
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
        }
    }
}

struct PlaceholderImageView: View {
    var body: some View {
        Image(systemName: "photo.fill")
            .foregroundColor(.white)
            .background(Color.gray)
            .frame(width: 100, height: 100)
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: Article.dummyData)
            .previewLayout(.sizeThatFits )
    }
}
