//
//  SearchVC.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 09/09/2021.
//

import UIKit
import RealmSwift

class SearchVC: UIViewController {
    
let searchController = UISearchController()
    
    var mainView : SearchView {
        return view as! SearchView
    }
    
    let realm = try! Realm()
    lazy var viewModel : SearchViewModel = {
        return SearchViewModel()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    
    func setUpView(){
        tableViewConfigration()
        confiugerSearchController()
        navigationView()
        initSearchViewModel()
    }
    
    func navigationView(){
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func confiugerSearchController(){
        searchController.searchBar.placeholder = "Movie name ... "
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = #colorLiteral(red: 0.09411764706, green: 0.1568627451, blue: 0.5647058824, alpha: 1)
        navigationItem.searchController = searchController
    }
    
    func tableViewConfigration(){
        mainView.searchTable.delegate = self
        mainView.searchTable.dataSource = self
        mainView.searchTable.separatorStyle = .none
        mainView.searchTable.prefetchDataSource = self
        mainView.searchTable.register(SearchTableCell.nib(), forCellReuseIdentifier: SearchTableCell.cellID)
    }
        
    
    func initSearchViewModel(){
        
        viewModel.showAlertClosure = { [weak self] in
            guard  let self = self  else {return}
            DispatchQueue.main.async {
                if let message = self.viewModel.alertMessage{
                    switch self.viewModel.state {
                    case  .error , .isEmpty, .isEmptyResult:
                        if let message = self.viewModel.alertMessage{
                            self.showAlert(message)
                        }
                    case .intervalError:
                        self.intervalAlert(message: message)
                    case .isLoading:
                        return
                    case .isGetData:
                        return
                    case .isTypSearchText:
                        return
                    }
                }
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
            guard  self != nil  else {return}
        }

        print("viewModel.state", viewModel.state)
        switch viewModel.state {
      
        case .error , .isEmpty ,.isEmptyResult:
            mainView.progress.stopAnimating()
            DispatchQueue.main.async {
                if let message = self.viewModel.alertMessage{
                    self.showAlert(message)
                }
            }
            
        case .isLoading:
            mainView.progress.startAnimating()
            DispatchQueue.main.async {
                print("print Start Loading Progress")
                UIView.animate(withDuration: 0.2, animations: {
                    self.mainView.searchTable.isHidden = true
                })
            }
            
        case.isGetData:
            mainView.progress.stopAnimating()
            DispatchQueue.main.async {
                print("print Stop Loading Progress")
                UIView.animate(withDuration: 0.2, animations: {
                    self.mainView.searchTable.isHidden = false
                })
            }
            
        case .isTypSearchText:
        
            DispatchQueue.main.async {
                self.mainView.searchTable.reloadData()
            }
        case .intervalError:
           return
        }
        
        viewModel.reloadTableViewClosure = { [weak self] in
            guard  let self = self  else {return}
            DispatchQueue.main.async {
                self.mainView.searchTable.reloadData()
            }
        }
        viewModel.getSearchList(searchText: "A")
    }
    
    
}


extension SearchVC : UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text , !text.isEmpty   {
            print("the text is ", text)
           // MARK: URI encoded
            let encodedTextValue = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
            viewModel.getMoviesBasedOnTextSearch(encodedTextValue)
        }
        
    }
}



extension SearchVC : UITableViewDelegate , UITableViewDataSource , UITableViewDataSourcePrefetching {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCellForRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableCell.cellID, for: indexPath) as!
            SearchTableCell
        let cellViewModel = viewModel.getCellViewModel(index: indexPath)
        cell.searchCellViewModel = cellViewModel
        cell.favoriteClosure = { [weak self] in
            guard  let self = self  else {return}
            self.viewModel.addToRealmDateBase(indexPath: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        viewModel.paginateTopRatedMoviesData(indexPaths: indexPaths)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedMovieID = viewModel.gotoMoviesDetails(indexPath: indexPath)
        let vc = MoviesDetailsVC()
        vc.moviesID = selectedMovieID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
