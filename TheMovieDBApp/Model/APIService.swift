//
//  APIService.swift
//  TheMovieDBApp
//
//  Created by Fandrian Rhamadiansyah on 19/12/20.
//

import Foundation
import Combine
import SwiftUI

class APIService {
    
    var component: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/movie/popular"
        components.queryItems = [URLQueryItem(name: "api_key", value: "9464ea28a33f26e195a059498b87f40f")]
        return components
        
    }
    
    var cancellable: AnyCancellable?
    
    var forTestData: ListMovies?
    
    private let baseImageURL = "https://image.tmdb.org/t/p/w500"
    
    init() {
        fetchURL { (bool) in
//            print("ASDAD")
        }
    }
    
    func fetchPopularMovie(page: Int) -> AnyPublisher<ListMovies,Error> {
        var urlComponent = component
        urlComponent.queryItems?.append(URLQueryItem(name: "page", value: "\(page)"))
        return URLSession.shared.dataTaskPublisher(for: urlComponent.url!)
            .map { $0.data }
            .decode(type: ListMovies.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    
    func fetchMovieList(category: DBCategory, page: Int) -> AnyPublisher<ListMovies,Error> {
        var urlComponent = component
        
        switch category {
        case .nowPlaying:
            urlComponent.path = "/3/movie/now_playing"
        case .topRated:
            urlComponent.path = "/3/movie/top_rated"
        case .upcoming:
            urlComponent.path = "/3/movie/upcoming"
        default:
            urlComponent.path = "/3/movie/popular"
        }
        
        urlComponent.queryItems?.append(URLQueryItem(name: "page", value: "\(page)"))
        
        return URLSession.shared.dataTaskPublisher(for: urlComponent.url!)
            .map { $0.data }
            .decode(type: ListMovies.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchURL(completion: @escaping (Bool) -> Void) {
        cancellable = fetchPopularMovie(page: 1)
            .sink(receiveCompletion: { _ in
                completion(true)
            }, receiveValue: { all in
                self.forTestData = all
//                completion(true)
            })
    }
    
    
    func fetchComment(movie_id: Int, page: Int) -> AnyPublisher<ListComments,Error> {
        var urlComponent = component
        urlComponent.path = "/3/movie/\(movie_id)/reviews"
        
        urlComponent.queryItems?.append(URLQueryItem(name: "page", value: "\(page)"))
        
        return URLSession.shared.dataTaskPublisher(for: urlComponent.url!)
            .map { $0.data }
            .decode(type: ListComments.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    func fetchSpecificMovie(movie_id: Int) -> AnyPublisher<MovieDetail,Error> {
        var urlComponent = component
        urlComponent.path = "/3/movie/\(movie_id)"
        
        return URLSession.shared.dataTaskPublisher(for: urlComponent.url!)
            .map { $0.data }
            .decode(type: MovieDetail.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    


}
