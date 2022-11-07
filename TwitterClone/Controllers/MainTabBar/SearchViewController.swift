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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
    }
    
    
    func configureTableView(){
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }


}



extension SearchViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "test"
        return cell
    }
    
    
}


extension SearchViewController:UISearchResultsUpdating,UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        print(searchController.searchBar.text)
    }
    
    
}
