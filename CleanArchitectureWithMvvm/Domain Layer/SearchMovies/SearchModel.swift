//
//  SearchModel.swift
//  CleanArchitectureWithMvvm
//
//  Created by mahesh mahara on 02/03/2025.
//


import Foundation

// MARK: - MovieSearchModel
struct MovieSearchModel: Codable {
    let page: Int?
    let results: [SearchResult]
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct SearchResult: Codable {
    let id: Int
    let originalTitle, overview: String
    let posterPath ,releaseDate, title: String
    let video: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video

    }
}

