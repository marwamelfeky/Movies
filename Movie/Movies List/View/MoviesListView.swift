//
//  ContentView.swift
//  Movie
//
//  Created by Marwa Elfeky on 03/08/2023.
//

import SwiftUI


struct MovieListView: View {
    
    //@Environment(\.openURL) var openUrl
    
    @StateObject var viewModel = MoviesListViewModel(service: MoviesService())
    
    var body: some View {
        NavigationView {
            List(viewModel.movies) { item in
                MovieView(movie: item)
            }.onAppear {
                self.viewModel.getMovies()
            }
            .navigationTitle(Text("Movies"))
        }
                    
        
    }
    func load(url: String?) {
        guard let link = url,
              let url = URL(string: link) else { return }

        //openUrl(url)
    }
    
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
