//
//  MovieListView.swift
//  TheMovieDBApp
//
//  Created by Fandrian Rhamadiansyah on 19/12/20.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject var homeVM = HomeViewModel.shared

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack (alignment: .leading) {
                ForEach(homeVM.movies) { movie in
                    NavigationLink(
                        destination:
                        MovieDetailView(movie: movie),
                        label: {
                            MovieView(movie: movie)
//                                .shadow(radius: 10 )
                        })
//                        .foregroundColor(.black)
                        .padding()
                    
                }
            }
        }
        
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
