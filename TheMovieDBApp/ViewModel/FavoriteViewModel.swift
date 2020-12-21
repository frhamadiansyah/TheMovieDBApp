//
//  ReadFavViewModel.swift
//  TheMovieDBApp
//
//  Created by Fandrian Rhamadiansyah on 20/12/20.
//

import Foundation
import Combine
import CoreData

class FavoriteViewModel: NSObject, ObservableObject {
    var service = APIService()

    var cancellable: AnyCancellable?

    @Published var favoritedMovie = [MovieDetail]()

    @Published var fav = [Favorites]()

    var LovedMovie = [Int]()

    private let favoriteController: NSFetchedResultsController<Favorites>

    init(managedObjectContext: NSManagedObjectContext) {
        favoriteController = NSFetchedResultsController(fetchRequest: Favorites.fetchAllID,
                                                        managedObjectContext: managedObjectContext,
                                                        sectionNameKeyPath: nil, cacheName: nil)

        super.init()

        favoriteController.delegate = self

        do {
            try favoriteController.performFetch()
            fav = favoriteController.fetchedObjects ?? []
            print("fetch core data \(fav.count)")
            fetchMovie { (_) in
//                print(:)
            }
        } catch {
            print("failed to fetch items!")
        }
    }
    
    func fetchMovie(completion: @escaping (MovieDetail) -> Void) {
        var lovedMovie = [MovieDetail]()
        self.favoritedMovie = []
        
        for data in fav {
            let movie_id = Int(data.movie_id)
            
            cancellable = service.fetchSpecificMovie(movie_id: movie_id)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error): print("Error \(error.localizedDescription)")
                    case .finished: print("Publisher is finished")
                        
                    }
                }, receiveValue: { data in
                    self.favoritedMovie.append(data)
//                    if lovedMovie.count == self.fav.count {
//                        completion(lovedMovie)
//                        self.favoritedMovie.append(contentsOf: lovedMovie)
//                    }
    //                completion(data)
                })
        }
        
        
    }


}


extension FavoriteViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let favoriteItems = controller.fetchedObjects as? [Favorites]
        else { return }

        fav = favoriteItems
    }
}


