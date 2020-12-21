//
//  FavoriteViewModel.swift
//  TheMovieDBApp
//
//  Created by Fandrian Rhamadiansyah on 20/12/20.
//

import Foundation
import Combine
import CoreData

class MovieDetailViewModel: ObservableObject {
    var service = APIService()
    
    var cancellable: AnyCancellable?
    
    var prevMovie: MovieDetail?
    
    @Published var selectedMovie: MovieDetail? {
        willSet {
            prevMovie = selectedMovie
            print("Before : \(selectedMovie)")
        }
        didSet {
            print("after : \(selectedMovie)")
            if prevMovie?.id != selectedMovie?.id {
                commentPage = 1
                fetchComment { _ in
                    print("complete fetch comment")
                }
            }
        }
    }
    
    @Published var updateItem: Favorites!
    
//    @Published var thisMovieLoved: Bool = false
    
    @Published var comments = [Comment]()
    
    static var shared = MovieDetailViewModel()
    
    var commentPage: Int = 1
    
    init() {

        print("-->>Object Created")
    }
    
    func writeData(context : NSManagedObjectContext) {
        
//
        if let movie = selectedMovie {
            let newFavorite = Favorites(context: context)
            newFavorite.movie_id = Int64(movie.id)
            newFavorite.title = movie.title
            newFavorite.overview = movie.overview
            newFavorite.release_date = movie.release
            newFavorite.image = movie.image
            newFavorite.rating = movie.rating
            newFavorite.rating_count = Int64(movie.ratingCount)
    //        newTask.content = content
            
            // saving data...
            
            do{
                
                try context.save()
                // success means closing view...
//                thisMovieLoved = true

            }
            catch{
                print(error.localizedDescription)
            }
        } else {
            print("No movie to be saved")
        }
        
    }
    
    func shouldFetchMore(review: Comment) -> Bool {
        let lastComment = comments.last?.id
        
        if review.id == lastComment {
            commentPage += 1
            return true
        } else {
            return false
        }
    }
    
    func fetchComment(completion: @escaping ([Comment]) -> Void) {
        if commentPage == 1 {
            self.comments = []
        }
        
        if let movie = selectedMovie {
            cancellable = service.fetchComment(movie_id: movie.id, page: commentPage)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error): print("Error \(error.localizedDescription)")
                    case .finished: print("Publisher is finished")
                    }
                }, receiveValue: { data in
                    self.comments.append(contentsOf: data.results)
                    completion(data.results)
                })
        }
        
    }
      
    deinit {
        print("-->>\(selectedMovie?.title) OBJECT DESTROYED!!!!")
    }
}
