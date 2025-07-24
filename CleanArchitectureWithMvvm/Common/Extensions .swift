//
//  Extensions .swift
//  CleanArchitectureWithMvvm
//
//  Created by mahesh mahara on 13/02/2025.
//

import Foundation
import SQLite3



struct APIEndpoint {
    static let baseURL = "https://api.themoviedb.org/3"

    static func moviesList(pagecount: Int) -> URL {
        return URL(string: "\(baseURL)/movie/popular?language=en-US&page=\(pagecount)")!
    }
    static func moviesSearch(query: String) -> URL {
        return URL(string: "\(baseURL)/search/movie?query=\(query)&include_adult=false&language=en-US&page=1")!
    }
    //https://api.themoviedb.org/3/search/movie?query=mu&include_adult=false&language=en-US&page=1

    static func moviesDetail(id: Int) -> URL {
        return URL(string: "\(baseURL)/movie/\(id)?language=en-US")!
        //
    }
}

enum SortOption {
    case All
    case byName
    case byId
}
