//
//  SearchVC.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 09/09/2021.
//

import UIKit

class SearchVC: UIViewController {

    let searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        searchController.searchBar.placeholder = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.tintColor = #colorLiteral(red: 0.09411764706, green: 0.1568627451, blue: 0.5647058824, alpha: 1)
    }
}


extension SearchVC : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text  {
            print("the text is ", text)
        }
        
    }
}
