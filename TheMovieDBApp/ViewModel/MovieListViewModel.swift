//
//  MovieListViewModel.swift
//  TheMovieDBApp
//
//  Created by Fandrian Rhamadiansyah on 21/12/20.
//

import Foundation
import Combine
import CoreData

class MovieListViewModel: ObservableObject {
    var service = APIService()
    
    var cancellable: AnyCancellable?
    
    @Published var movie: MovieDetail?
    
    init(movie_id: Int) {
        fetchMovie(movie_id: movie_id) { _ in
            
        }
    }
    
    func fetchMovie(movie_id: Int, completion: @escaping (MovieDetail) -> Void) {
        
        
        cancellable = service.fetchSpecificMovie(movie_id: movie_id)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error): print("Error \(error.localizedDescription)")
                case .finished: print("Publisher is finished")
                    
                }
            }, receiveValue: { data in
                self.movie = data
                
            })
        
        
        
    }
}
