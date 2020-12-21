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
    @Published var favoritedMovie = [MovieDetail]()

    @Published var fav = [Favorites]()


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

        } catch {
            print("failed to fetch items!")
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


