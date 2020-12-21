//
//  HomeViewModel.swift
//  TheMovieDBApp
//
//  Created by Fandrian Rhamadiansyah on 19/12/20.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    var service = APIService()
    
    var cancellable: AnyCancellable?
    
    static var shared = HomeViewModel()
//    var cancellable : Set<AnyCancellable> = Set()
    @Published var page: Int = 1
    
    @Published var movies = [MovieDetail]()
    
    private var previousCategory: DBCategory = .popular
    
    @Published var dbCategory: DBCategory = .popular {
        willSet {
            previousCategory = dbCategory
            print("Before : \(dbCategory.rawValue)")
        }
        didSet {
            print("after : \(dbCategory.rawValue)")
            if previousCategory != dbCategory {
                page = 1
                fetchURL { _ in
                    print("new updated")
                }
            }
        }
    }
    
    init() {
        fetchURL { _ in
            print("Done")
        }
    }
    
    func shouldFetchMore(movie: MovieDetail) -> Bool {
        let lastMovie = movies.last?.id
        
        if movie.id == lastMovie {
            page += 1
            return true
        } else {
            return false
        }
    }
    
    func fetchURL(completion: @escaping ([MovieDetail]) -> Void) {
        if page == 1 {
            self.movies = []
        }
        
        cancellable = service.fetchMovieList(category: dbCategory, page: page)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error): print("Error \(error.localizedDescription)")
                case .finished: print("Publisher is finished")
                }
            }, receiveValue: { data in
                self.movies.append(contentsOf: data.results)
                completion(data.results)
            })
    }
    
}
