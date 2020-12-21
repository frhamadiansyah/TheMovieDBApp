//
//  LovedMoviesView.swift
//  TheMovieDBApp
//
//  Created by Fandrian Rhamadiansyah on 20/12/20.
//

import SwiftUI

struct LovedMoviesView: View {
    
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var favoriteVM : FavoriteViewModel
    
    
    var body: some View {
        ScrollView(.vertical) {
            if favoriteVM.fav.isEmpty {
                VStack {
                    Spacer()
                    Text("You have no favorite movie")
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding()
            } else {
                LazyVStack(alignment: .leading) {
                    ForEach(favoriteVM.fav) { movie in
                        FavoritedMovieView(movie_id: Int(movie.movie_id))
                            .padding()
                    }
                }
            }
            
        }
        .navigationTitle("Favorites")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarColor(backgroundColor: UIColor(named: "Primary"))
    }

}


struct LovedMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        LovedMoviesView(favoriteVM: FavoriteViewModel(managedObjectContext: PersistenceController.shared.container.viewContext))
    }
}
