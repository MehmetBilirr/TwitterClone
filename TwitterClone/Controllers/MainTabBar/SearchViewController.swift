//
//  SearchViewController.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 2.11.2022.
//

import UIKit


protocol SearchViewInterface:AnyObject {
    var isActive: Bool {get}
    func configureTableView()
    func fetchUsers()
    func reloadData()
}

final class SearchViewController: UIViewController {
    private let searchController = UISearchController()
    private let tableView = UITableView()
    private let viewModel = SearchViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        
        viewModel.view = self
        viewModel.navigationController = navigationController
        viewModel.viewDidload()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchUsers()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}



extension SearchViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
        cell.configure(user: viewModel.getusers(at: indexPath))
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        viewModel.didSelectRowAt(at: indexPath)
    }
    
}


extension SearchViewController:UISearchResultsUpdating,UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else {return}
        
        let lowerText = text.lowercased()
        
        
        viewModel.filteredUsers(text: text)
        
    }

    
}

extension SearchViewController:SearchViewInterface {
    func fetchUsers() {
        viewModel.fetchUsers()
    }
    
    var isActive: Bool {
        searchController.isActive
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self

        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    
}

