//
//  UserListViewController.swift
//  CleanArchitectureWithMvvm
//
//  Created by mahesh mahara on 12/02/2025.
//


import UIKit
import Combine
import SDWebImage


class UserListViewController: UIViewController {
    private let tableView = UITableView()
    var viewModel: UserListViewModel!
    private var cancellables = Set<AnyCancellable>()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    private let searchBar = UISearchBar()
    @Published var isSearching: Bool = false
    
    private lazy var sortSegmentedControl: UISegmentedControl = {
         let control = UISegmentedControl(items: ["All","Name", "ID"])
         control.selectedSegmentIndex = 0
         control.addTarget(self, action: #selector(sortOptionChanged(_:)), for: .valueChanged)
         return control
     }()

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
        fetchUsers()
        bindViewModel()
        setupFilterButton()
        setupUI()
        setupNavigationBar()
        setupActivityIndicator()
     //   SearchviewModel?.search(query: "Mufasa")
        
        self.navigationItem.title = "New Movies List "
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Save user data and release resources
//        saveData()
//        releaseResources()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Restore state and resume tasks
//        restoreState()
//        resumeTasks()
    }
    
    
    private func setupFilterButton() {
         // Create the filter button
         let filterButton = UIBarButtonItem(
             image: UIImage(systemName: "line.horizontal.3.decrease.circle"), // Use a system icon or custom image
             style: .plain,
             target: self,
             action: #selector(filterButtonTapped)
         )

         // Add the button to the navigation item
         navigationItem.rightBarButtonItem = filterButton
     }

    @objc private func filterButtonTapped() {
           // Handle the filter button tap
           print("Filter button tapped")
       
       }
    private func setupNavigationBar() {
           navigationItem.titleView = sortSegmentedControl
       }

    
    @objc private func sortOptionChanged(_ sender: UISegmentedControl) {
         switch sender.selectedSegmentIndex {
         case 0:
             viewModel.sortOption = .All
             self.tableView.reloadData()
         case 1:
             viewModel.sortOption = .byName
             self.tableView.reloadData()
         case 2:
             viewModel.sortOption = .byId
             self.tableView.reloadData()
         default:
             break
         }
     }
    

    private func setupTableView() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    
    
    // MARK: - Setup UI
    private func setupUI() {
        
        view.backgroundColor = .white

        // Configure Search Bar
        searchBar.placeholder = "Search..."
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)

        // Configure TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
      

        // Add Constraints
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    private func setupActivityIndicator() {
          activityIndicator.center = view.center
          activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
          view.addSubview(activityIndicator)
     }
    


    private func setupViewModel() {
         let apiService = APIService(token: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNjNhMmI4OTQ3NzA2NGJkNzk3Njg5YTA2N2RjZmZmMCIsIm5iZiI6MTczODkwNTIwMS45Mjk5OTk4LCJzdWIiOiI2N2E1OTY3MTRkNTM2Y2I5MzI2NmQ1NzAiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.z_RIbAKn-3nU77dQb8ewaloxaIxx7u_HfcmnKA0YN2o")
         let fetchUsersUseCase = DefaultFetchUsersUseCase(apiService: apiService)
        let searchUseCase = SearchUseCase(apiService: apiService)
        viewModel = UserListViewModel(fetchUsersUseCase: fetchUsersUseCase, searchUseCase: searchUseCase)
     }

    private func bindViewModel() {
        
        // Bind ViewModel to View
        viewModel.updateLoadingStatus = { [weak self] isLoading in
            print("isLoading == \(isLoading)")
            DispatchQueue.main.async {
                isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
            }
        }
        
      //  activityIndicator.startAnimating()
        viewModel.$allMovies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
               // self?.activityIndicator.stopAnimating()
            }
            .store(in: &cancellables)
        
        viewModel.$searchResults
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isSearching in
                print("Is searching: \(isSearching)")
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$sortOption
            .receive(on: DispatchQueue.main)
            .sink { [weak self] SortByNmae in
                print("Is searching: \(SortByNmae)")
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                if let error = error {
                    self?.showError(error)
                }
            }
            .store(in: &cancellables)
    }


     private func fetchUsers() {
         viewModel.fetchUsers()
         viewModel.setupSorting()
        
     }
    
    
    private func showError(_ message: String) {
          let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default))
          present(alert, animated: true)
      }
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  isSearching ? viewModel.searchResults.count : viewModel.allMovies.count
        //viewModel.searchResults.count
            
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MoviesTableViewCell else {
             fatalError("Unable to create cell")
         }
        
        if isSearching {
             // Ensure indexPath.row is within bounds of filteredData
             guard indexPath.row < viewModel.searchResults.count else {
                 return cell
             }
             let letestmovies = viewModel.searchResults[indexPath.row]
            cell.filter(with: letestmovies)
         } else {
             // Ensure indexPath.row is within bounds of alldata
             guard indexPath.row < viewModel.allMovies.count else {
                 return cell
             }
             let letestmovies = viewModel.allMovies[indexPath.row]
             cell.fill(with: letestmovies)
         }
       return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isSearching {
            if indexPath.row == (viewModel.searchResults.count) - 1 {
                fetchUsers() // Load next page
            }
        }else{
            if indexPath.row == (viewModel.allMovies.count) - 1 {
                fetchUsers() // Load next page
            }
            
        }
        
      }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isSearching {
            let user = viewModel.searchResults[indexPath.row]
            print("Navigating to detail view for user: \(user.overview)")
            detailView(moviesID: user.id)
            
        }else{
            
            let user = viewModel.allMovies[indexPath.row]
            print("Navigating to detail view for user: \(user.overview)")
            detailView(moviesID: user.id)
        }
        
    }
    
    func detailView(moviesID:Int){
        
        
        let apiService = APIService(token: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNjNhMmI4OTQ3NzA2NGJkNzk3Njg5YTA2N2RjZmZmMCIsIm5iZiI6MTczODkwNTIwMS45Mjk5OTk4LCJzdWIiOiI2N2E1OTY3MTRkNTM2Y2I5MzI2NmQ1NzAiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.z_RIbAKn-3nU77dQb8ewaloxaIxx7u_HfcmnKA0YN2o")
        let fetchUserDetailUseCase = DefaultFetchUserDetailUseCase(apiService: apiService)
        let detailViewModel = UserDetailViewModel(fetchUserDetailUseCase: fetchUserDetailUseCase)
        let detailViewController = UserDetailViewController(viewModel: detailViewModel, userId: moviesID)
        navigationController?.pushViewController(detailViewController, animated: true)
        
        
    }
    
    
    
    
    
}

extension UserListViewController: UISearchBarDelegate {

       
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        tableView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.search(query: searchBar.text ?? "")
        isSearching = true
    }
}


