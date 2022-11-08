//
//  SearchViewController.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 2.11.2022.
//

import UIKit
protocol SearchViewControllerProtocol:AnyObject{
    
    func didTapCell(user:User)
}

class SearchViewController: UIViewController {
    private let searchController = UISearchController()
    private let tableView = UITableView()
    var userArray = [User]()
    var filteredArray = [User]()
    private let searchVM = SearchViewModel()
    static weak var delegate : SearchViewControllerProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        searchVM.delegate = self
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        searchVM.fetchUsers()
    }
    
    
    func configureTableView(){
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self

        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}



extension SearchViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredArray.count
        }else {
            return userArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
        
        if searchController.isActive {
            let user = filteredArray[indexPath.row]
            cell.configure(user: user)
        }else {
            let user = userArray[indexPath.row]
            cell.configure(user: user)
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileVC = ProfileViewController()
        if searchController.isActive {
            
            let user = filteredArray[indexPath.row]
            
            
            profileVC.headerView.configure(user: user)
            navigationController?.pushViewController(profileVC, animated: true)
            searchController.isActive = false
            
            
        }else {
            let user = userArray[indexPath.row]
            profileVC.headerView.configure(user: user)
            navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
}


extension SearchViewController:UISearchResultsUpdating,UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else {return}
        
        let lowerText = text.lowercased()
        
        
        filterForSearchText(text: lowerText)
        
    }
    
    private func filterForSearchText(text:String) {
        filteredArray = userArray.filter({ user in
            if text != "" {
                
                let re =  user.fullname.lowercased().contains(text) || user.username.lowercased().contains(text)
                
               
                return re
            }else {
                return false
            }
            
        })
        tableView.reloadData()
    }
    
    
}

extension SearchViewController:SearchViewModelProtocol {
    func getUsers(users: [User]) {
        userArray = users
        tableView.reloadData()
    }
    
    
}
