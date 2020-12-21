//
//  MovieDescriptionView.swift
//  TheMovieDBApp
//
//  Created by Fandrian Rhamadiansyah on 21/12/20.
//

import SwiftUI

struct MovieDescriptionView: View {
    
    @FetchRequest(fetchRequest: Favorites.fetchAllID)
    var favoritedMovie: FetchedResults<Favorites>
    
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var favData = MovieDetailViewModel.shared
    
    let movie: MovieDetail
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(UIColor.systemBackground))
                
                .shadow(color: .primary, radius: 5)
            HStack(alignment: .top, spacing: 10) {
                URLImageView(urlString: movie.image)
                    .cornerRadius(5)
                VStack(alignment: .leading, spacing: 2) {
                    
                    HStack(alignment: .top) {
                        Text(movie.title)
                            .font(.title2)
                            .bold()
                            .foregroundColor(.primary)
                        Spacer()
                        Button(action: {
                            if checkLoved() {
                                deleteLoved()
                            } else {
                                favData.writeData(context: context)
                            }
                            
                        }, label: {
                            Image(systemName: checkLoved() ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                        })
//                        .padding(.horizontal)
                    }
                    
                    Text(toDate(date: movie.release), style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    HStack(alignment: .center, spacing: 5) {
                        HStack(alignment: .center, spacing: 2) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f", movie.rating))
                                .font(.footnote)
                                .foregroundColor(.primary)
                                .lineLimit(1)
                                .padding(.trailing, 1)
                        }
                        .padding(1)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.secondary))
                        
                        Text("(\(movie.ratingCount))")
                            .foregroundColor(.secondary)
                            .font(.footnote)
                        Spacer()
                    }
                    .padding(.top, 5)
                    
                    Text(movie.overview)
                        .font(.footnote)
                        .foregroundColor(.primary)
                        .padding(.top)
                    
                    Spacer()
                }
            }
            .padding()
            
        }
        
        
        .onAppear(perform: {
            self.favData.selectedMovie = movie
        })

        
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

struct MovieDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDescriptionView(movie: MovieDetail(id: 765123, title: "Christmas Crossfire", overview: "ASDA", release:  "2020-12-04", image: "/ajKpYK7XdzIYjy9Uy8nkgRboKyv.jpg", rating: 5.0, ratingCount: 23))
    }
}
