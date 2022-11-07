//
//  SearchViewController.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 2.11.2022.
//

import UIKit

class SearchViewController: UIViewController {
    private let searchController = UISearchController()
    private let tableView = UITableView()
    var userArray = [User]()
    var filteredArray = [User]()
    private let searchVM = SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        setup()
        
        
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
    
    func setup(){
        searchVM.fetchUsers {  uARray in
            self.userArray = uARray
            self.tableView.reloadData()
        }
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
