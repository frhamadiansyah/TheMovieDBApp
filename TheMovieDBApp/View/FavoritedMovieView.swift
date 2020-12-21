//
//  FavoritedMovieView.swift
//  TheMovieDBApp
//
//  Created by Fandrian Rhamadiansyah on 21/12/20.
//

import SwiftUI

struct FavoritedMovieView: View {
    
    @ObservedObject var movieVM: MovieListViewModel
    
    let movie_id: Int
    
    init(movie_id: Int) {
        self.movie_id = movie_id
        self.movieVM = MovieListViewModel(movie_id: movie_id)
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            if movieVM.movie != nil {
                NavigationLink(
                    destination: MovieDetailView(movie: movieVM.movie!),
                    label: {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(UIColor.systemBackground))
                                .shadow(color: .primary, radius: 5)
                            HStack(alignment: .top, spacing: 10) {
                                URLImageView(urlString: movieVM.movie!.image)
                                    .cornerRadius(5)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(movieVM.movie!.title)
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(.primary)
                                        
                                    Text(toDate(date: movieVM.movie!.release), style: .date)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    
                                    HStack(alignment: .center, spacing: 5) {
                                        HStack(alignment: .center, spacing: 2) {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                            Text(String(format: "%.1f", movieVM.movie!.rating))
                                                .font(.footnote)
                                                .foregroundColor(.primary)
                                                .lineLimit(1)
                                                .padding(.trailing, 1)
                                        }
                                        .padding(1)
                                        .overlay(RoundedRectangle(cornerRadius: 2).stroke(lineWidth: 1).foregroundColor(.secondary))

                                        Text("(\(movieVM.movie!.ratingCount))")
                                            .foregroundColor(.secondary)
                                            .font(.footnote)
                                        Spacer()
                                    }
                                    .padding(.top, 5)
                                    
                                    Text(movieVM.movie!.overview)
                                        .font(.footnote)
                                        .foregroundColor(.primary)
                                        .lineLimit(5)
                                        .padding(.top)
                                        
                                    Spacer()
                                }
                            }
                            .padding()
                        }
                    })
                
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }

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

struct FavoritedMovieView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritedMovieView(movie_id: 297761)
    }
}
