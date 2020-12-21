//
//  LovedMoviesView.swift
//  TheMovieDBApp
//
//  Created by Fandrian Rhamadiansyah on 20/12/20.
//

import SwiftUI

struct LovedMoviesView: View {
    @FetchRequest(fetchRequest: Favorites.fetchAllID)
    var favoritedMovie: FetchedResults<Favorites> 
    
//    @ObservedObject var favoriteVM = FavoriteViewModel(managedObjectContext: <#NSManagedObjectContext#>)
    
    @Environment(\.managedObjectContext) var context
    
    
    var body: some View {
        ScrollView(.vertical) {
            //            LazyVStack(alignment: .leading) {
            if favoritedMovie.isEmpty {
                VStack {
                    Spacer()
                    Text("You have no favorite movie")
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding()
            } else {
                LazyVStack(alignment: .leading) {
                    ForEach(favoritedMovie, id: \.self) { movie in
//                        Text("\(movie.movie_id)")
                        NavigationLink(
                            destination:
                                MovieDetailView(movie: createMovie(movie: movie)),
                            label: {
                                MovieView(movie: createMovie(movie: movie))
                            })
                            .padding()
                    }
                }
            }
            
        }
        .navigationTitle("Favorites")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarColor(backgroundColor: UIColor(named: "Primary"))
    }
    
    func createMovie(movie: FetchedResults<Favorites>.Element) -> MovieDetail {
        return MovieDetail(id: Int(movie.movie_id), title: movie.title ?? "", overview: movie.overview ?? "", release:  movie.release_date ?? "", image: movie.image ?? "", rating: Float(movie.rating), ratingCount: Int(movie.rating_count))
    }
}

//MovieDetail(id: movie.movie_id, title: movie.title, overview: movie.overview, release:  movie.release_date, image: movie.image, rating: movie.rating, ratingCount: movie.rating_count)
//
//    .init(id: Int(movie.movie_id), title: movie.title ?? "", overview: movie.overview ?? "", release: movie.release_date ?? "", image: movie.image ?? "")

struct LovedMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        LovedMoviesView()
    }
}
