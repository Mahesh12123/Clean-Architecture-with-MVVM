//
//  SearchUseCase.swift
//  CleanArchitectureWithMvvm
//
//  Created by mahesh mahara on 02/03/2025.
//

import Foundation
import Combine
protocol FetchMoviesrSearchUseCase {
    func Search(query: String) -> AnyPublisher<MovieSearchModel, Error>
}

class SearchUseCase {
    private let apiService: APIService

    init(apiService: APIService) {
        self.apiService = apiService
    }

    func Search(query: String) -> AnyPublisher<MovieSearchModel, Error>{
        let endpoint = APIEndpoint.moviesSearch(query: query)
        return apiService.request(endpoint: endpoint)
            .map { (searchModel: MovieSearchModel) in
                return searchModel
            }
            .eraseToAnyPublisher()
    }
}
