//
//  UserListViewModel.swift
//  CleanArchitectureWithMvvm
//
//  Created by mahesh mahara on 12/02/2025.
//

import Foundation
import Combine


class UserListViewModel {
    private let fetchUsersUseCase: FetchUsersUseCase
    private let searchUseCase: SearchUseCase
    @Published var error:  String?
    private var currentPage = 1
    private var canLoadMore = true
    var isLoading: Bool = false {
           didSet {
               self.updateLoadingStatus?(isLoading)
           }
       }
    var updateLoadingStatus: ((Bool) -> Void)?
    @Published var allMovies: [Result] = [] // All users fetched from the API
    @Published var isSearching: Bool = false
    @Published var searchResults: [SearchResult] = []
    @Published var sortOption: SortOption = .byName
    
    private var cancellables = Set<AnyCancellable>()
    
    
    

    init(fetchUsersUseCase: FetchUsersUseCase ,searchUseCase: SearchUseCase) {
        self.fetchUsersUseCase = fetchUsersUseCase
        self.searchUseCase = searchUseCase
       
    }
    
    
    
    func fetchUsers() {
        
        guard !isLoading && canLoadMore else { return }

               isLoading = true
               fetchUsersUseCase.fetchUsers(page: currentPage)
                   .receive(on: DispatchQueue.main)
                   .sink { [weak self] completion in
                      
                       switch completion {
                       case .failure(let error):
                           self?.error = error.localizedDescription
                           self?.isLoading = false
                       case .finished:
                           break
                       }
                   } receiveValue: { [weak self] response in
                       self?.allMovies.append(contentsOf: response.results)
                       self?.canLoadMore = response.page != nil
                       if self?.canLoadMore == true {
                           self?.currentPage += 1
                       }
                       self?.isLoading = false
                     
                   }
                   .store(in: &cancellables)
           
    }
    func search(query: String) {
        searchUseCase.Search(query: query)
        
            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print("Decoding failed with error: \(error)")
//                }
//            }, receiveValue: { model in
//                print("Decoded model: \(String(describing: model.totalResults))")
//            })
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.error = error.localizedDescription
                    print("errpr = \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] results in
                self?.searchResults = results.results
               // print("results = \(results.results)")
            }
            .store(in: &cancellables)
    }
    
     func setupSorting() {
          $sortOption
              .sink { [weak self] _ in
                  self?.sortUsers()
              }
              .store(in: &cancellables)
      }

     func sortUsers() {
            switch sortOption {
            case .byName:
                allMovies.sort { $0.originalTitle < $1.originalTitle }
            case .byId:
                allMovies.sort { $0.id < $1.id }
            case .All:
                fetchUsers()
            }
        }
    
    
}




