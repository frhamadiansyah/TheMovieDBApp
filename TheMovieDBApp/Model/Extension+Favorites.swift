//
//  Extension+Favorites.swift
//  TheMovieDBApp
//
//  Created by Fandrian Rhamadiansyah on 20/12/20.
//

import Foundation
import CoreData

extension Favorites {
    
//    static func dueSpecificData(id: String) -> NSFetchRequest<Favorites> {
//        let request: NSFetchRequest<Favorites> = Favorites.fetchRequest()
//        request.predicate = NSPredicate(format: "movie_id == %@", id as CVarArg)
//        request.sortDescriptors = [NSSortDescriptor(key: "movie_id", ascending: true)]
//
//        return request
//    }
    static var fetchAllID: NSFetchRequest<Favorites> {
    let request: NSFetchRequest<Favorites> = Favorites.fetchRequest()
//    request.predicate = NSPredicate(format: "dueDate < %@", Date.nextWeek() as CVarArg)
    request.sortDescriptors = [NSSortDescriptor(key: "movie_id", ascending: true)]

    return request
  }
    
    
}
