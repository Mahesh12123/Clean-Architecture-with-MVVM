//
//  UserDetailViewModel.swift
//  CleanArchitectureWithMvvm
//
//  Created by mahesh mahara on 12/02/2025.
//

import Foundation
import Combine

class UserDetailViewModel {
    private let fetchUserDetailUseCase: FetchUserDetailUseCase
    @Published var userDetail: MovieDetailModel?
    @Published var error: String?
    var isLoading: Bool = false {
           didSet {
               self.updateLoadingStatus?(isLoading)
           }
       }
    var updateLoadingStatus: ((Bool) -> Void)?

    init(fetchUserDetailUseCase: FetchUserDetailUseCase) {
        self.fetchUserDetailUseCase = fetchUserDetailUseCase
    }

    func fetchUserDetail(userId: Int) {
        
        guard !isLoading  else { return }
        isLoading = true
        fetchUserDetailUseCase.fetchUserDetail(userId: userId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                    self?.isLoading = false
                }
            } receiveValue: { [weak self] userDetail in
                self?.userDetail = userDetail
               self?.isLoading = false
            }
            .store(in: &cancellables)
    }

    private var cancellables = Set<AnyCancellable>()
}
