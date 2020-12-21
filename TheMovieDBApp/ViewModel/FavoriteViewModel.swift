//
//  ReadFavViewModel.swift
//  TheMovieDBApp
//
//  Created by Fandrian Rhamadiansyah on 20/12/20.
//

import Foundation
import Combine
import CoreData

//class FavoriteViewModel: NSObject, ObservableObject {
//    var service = APIService()
//
//    var cancellable: AnyCancellable?
//
//    @Published var favoritedMovie = [MovieDetail]()
//
//    @Published var fav = [Favorites]()
//
//    var LovedMovie = [Int]()
//
//    private let favoriteController: NSFetchedResultsController<Favorites>
//
//    init(managedObjectContext: NSManagedObjectContext) {
//        favoriteController = NSFetchedResultsController(fetchRequest: Favorites.fetchAllID,
//                                                        managedObjectContext: managedObjectContext,
//                                                        sectionNameKeyPath: nil, cacheName: nil)
//
//        super.init()
//
//        favoriteController.delegate = self
//
//        do {
//            try favoriteController.performFetch()
//            fav = favoriteController.fetchedObjects ?? []
//        } catch {
//            print("failed to fetch items!")
//        }
//    }
//
//
//}
//
//
//extension FavoriteViewModel: NSFetchedResultsControllerDelegate {
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        guard let favoriteItems = controller.fetchedObjects as? [Favorites]
//        else { return }
//
//        fav = favoriteItems
//    }
//}

//
//class TodoItemStorage: NSObject, ObservableObject {
//    @Published var dueSoon: [TodoItem] = []
//    private let dueSoonController: NSFetchedResultsController<TodoItem>
//    
//    init(managedObjectContext: NSManagedObjectContext) {
//        dueSoonController = NSFetchedResultsController(fetchRequest: TodoItem.dueSoonFetchRequest,
//                                                       managedObjectContext: managedObjectContext,
//                                                       sectionNameKeyPath: nil, cacheName: nil)
//        
//        super.init()
//        
//        dueSoonController.delegate = self
//        
//        do {
//            try dueSoonController.performFetch()
//            dueSoon = dueSoonController.fetchedObjects ?? []
//        } catch {
//            print("failed to fetch items!")
//        }
//    }
//}
//
//extension TodoItemStorage: NSFetchedResultsControllerDelegate {
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        guard let todoItems = controller.fetchedObjects as? [TodoItem]
//        else { return }
//        
//        dueSoon = todoItems
//    }
//}
