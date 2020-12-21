//
//  MovieDetailView.swift
//  TheMovieDBApp
//
//  Created by Fandrian Rhamadiansyah on 19/12/20.
//

import SwiftUI

struct MovieDetailView: View {
    
    @FetchRequest(fetchRequest: Favorites.fetchAllID)
    var favoritedMovie: FetchedResults<Favorites>
    
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var favData = MovieDetailViewModel.shared
    
    let movie: MovieDetail
    
    
    var body: some View {
        
        // Movie Description
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading) {
                MovieDescriptionView(movie: movie)
//                    .frame(maxHeight: UIScreen.main.bounds.height)
                    .padding()
                
                Text("Reviews")
                    .bold()
                    .padding(.horizontal)
                
                if favData.comments.isEmpty {
                    Text("There is no comment")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
//                        .bold()
                        .padding()
                }
                ForEach(favData.comments) { comment in
                    CommentView(comment: comment)
                        .onAppear(perform: {
                            if favData.shouldFetchMore(review: comment) {
                                favData.fetchComment { _ in
                                    print("fetch \(movie.title) comment page \(favData.commentPage) complete")
                                }
                            }
                        })
                        .padding()
                    
                }
                
            }
            
        }
//        .onAppear(perform: {
//            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
//        })
        .navigationBarTitle(movie.title)
        .navigationBarColor(backgroundColor: UIColor(named: "Primary"))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func checkLoved() -> Bool {
        let results = self.favoritedMovie.filter { $0.movie_id == movie.id }
        
        if results.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func deleteLoved() {
        let results = self.favoritedMovie.filter { $0.movie_id == movie.id }
        
        context.delete(results[0])
        do {
            try context.save()
        } catch {
            print("fail delete")
        }
        
    }
    
    func toDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let result = dateFormatter.date(from: date) {
            return result
        } else {
            return Date()
        }
        
    }
    
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: MovieDetail(id: 765123, title: "Christmas Crossfire", overview: "ASDA", release:  "2020-12-04", image: "/ajKpYK7XdzIYjy9Uy8nkgRboKyv.jpg", rating: 5.0, ratingCount: 23))
        //        MovieDetailView()
    }
}

