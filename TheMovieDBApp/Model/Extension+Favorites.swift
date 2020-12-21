//
//  Extension+Favorites.swift
//  TheMovieDBApp
//
//  Created by Fandrian Rhamadiansyah on 20/12/20.
//

import Foundation
import CoreData

extension Favorites {
    

    static var fetchAllID: NSFetchRequest<Favorites> {
    let request: NSFetchRequest<Favorites> = Favorites.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "liked_date", ascending: false)]

    return request
  }
    
    
    
    
}
