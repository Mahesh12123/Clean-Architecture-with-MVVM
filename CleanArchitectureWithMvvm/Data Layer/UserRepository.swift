//
//  UserRepository.swift
//  CleanArchitectureWithMvvm
//
//  Created by mahesh mahara on 12/02/2025.
//

import Foundation
import Combine

//protocol UserRepository {
//    func fetchUsers(token: String) -> AnyPublisher<PopularMovieModel, Error>
//}
//
//class UserRepositoryImpl: UserRepository {
//    func fetchUsers(token: String) -> AnyPublisher<PopularMovieModel, Error> {
//        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc")!
//        var request = URLRequest(url: url)
//        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//
//        return URLSession.shared.dataTaskPublisher(for: request)
//            .map(\.data)
//            .decode(type: PopularMovieModel.self, decoder: JSONDecoder())
//            .eraseToAnyPublisher()
//    }
//}

