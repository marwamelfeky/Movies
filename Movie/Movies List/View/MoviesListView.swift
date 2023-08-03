//
//  ContentView.swift
//  Movie
//
//  Created by Marwa Elfeky on 03/08/2023.
//

import SwiftUI
import Combine

struct MovieListView: View {
    
    @StateObject var viewModel = MoviesListViewModel(service: MoviesListService())
    private let rowHeight = 160.0
    var body: some View {
        
        NavigationView {

                List(viewModel.movies) { item in
                    
                    NavigationLink {
                        MoviesDetailsView(movie: item)
                    } label: {
                        MovieView(movie: item)
                    }.frame(height: rowHeight).listRowInsets(EdgeInsets())
                }.onAppear {
                    self.viewModel.getMovies()
                }
            
            .navigationTitle(Text("Movies"))
        }
                    
        
    }    
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
