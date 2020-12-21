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
                        .onAppear(perform: {
                            if homeVM.shouldFetchMore(movie: movie) {
                                homeVM.fetchURL { _ in
                                    print("fetch \(homeVM.dbCategory.rawValue) page \(homeVM.page) complete")
                                }
                            }
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
