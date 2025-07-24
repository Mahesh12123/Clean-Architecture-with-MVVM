//
//  Use Cases.swift
//  CleanArchitectureWithMvvm
//
//  Created by mahesh mahara on 13/02/2025.
//

import Foundation
import Combine
protocol FetchUserDetailUseCase {
    func fetchUserDetail(userId: Int) -> AnyPublisher<MovieDetailModel, Error>
}

class DefaultFetchUserDetailUseCase: FetchUserDetailUseCase {
    private let apiService: APIService

    init(apiService: APIService) {
        self.apiService = apiService
    }

    func fetchUserDetail(userId: Int) -> AnyPublisher<MovieDetailModel, Error> {
        let endpoint = APIEndpoint.moviesDetail(id: userId)
        return apiService.request(endpoint: endpoint)
            .map { (userDetail: MovieDetailModel) in
                return userDetail
            }
            .eraseToAnyPublisher()
    }
}
