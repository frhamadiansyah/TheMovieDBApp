//
//  Model.swift
//  TheMovieDBApp
//
//  Created by Fandrian Rhamadiansyah on 19/12/20.
//

import Foundation

struct ListMovies: Decodable {
    let page: Int
    let results: [MovieDetail]
}

struct MovieDetail: Identifiable, Decodable {
    let id: Int
    let title: String
    let overview: String
    let release: String
    let image: String
    let rating: Float
    let ratingCount: Int
    
    enum CodingKeys: String, CodingKey {
            case id = "id"
            case title = "title"
            case overview = "overview"
            case release = "release_date"
            case image = "poster_path"
            case rating = "vote_average"
            case ratingCount = "vote_count"
        }
    
}

enum DBCategory: String, CaseIterable {
    case popular = "Popular"
    case upcoming = "Upcoming"
    case topRated = "Top Rated"
    case nowPlaying = "Now Playing"
}

struct ListComments: Decodable {
    let page: Int
    let results: [Comment]
}

struct Comment: Decodable, Identifiable {
    let id: String
    let author: String
    let updated_at: String
    let author_details: CommentAuthor
    let content: String
}

struct CommentAuthor: Decodable {
    let name: String
    let rating: Int?
}

