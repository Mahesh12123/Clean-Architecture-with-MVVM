//
//  Use Cases.swift
//  CleanArchitectureWithMvvm
//
//  Created by mahesh mahara on 12/02/2025.
//

import Foundation
import Combine

protocol FetchUsersUseCase {
  
    func fetchUsers(page: Int) -> AnyPublisher<PopularMovieModel, Error>
}

class DefaultFetchUsersUseCase: FetchUsersUseCase {
    private let apiService: APIService

    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func fetchUsers(page: Int) -> AnyPublisher<PopularMovieModel, Error> {
        let endpoint = APIEndpoint.moviesList(pagecount: page)
        return apiService.request(endpoint: endpoint)
            .map { (users: PopularMovieModel) in
                return users
            }
            .eraseToAnyPublisher()
    }
}

