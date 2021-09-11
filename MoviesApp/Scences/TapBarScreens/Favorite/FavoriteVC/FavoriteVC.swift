//
//  FavoriteVC.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 09/09/2021.
//

import UIKit
import RealmSwift

class FavoriteVC: UIViewController {
    let realm = try! Realm()
    
    
    lazy var viewModel : FavoriteViewModel = {
        return FavoriteViewModel()
    }()
    
    var mainView : FavoriteView {
        return view as! FavoriteView
    }
    
    deinit {
        print("error happed!!")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initalViewModel()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableViewConfigration()
    }
    
    func tableViewConfigration(){
        mainView.favoriteTable.delegate = self
        mainView.favoriteTable.dataSource = self
        mainView.favoriteTable.separatorStyle = .none
        mainView.favoriteTable.register(FavoriteTabelCell.nib(), forCellReuseIdentifier: FavoriteTabelCell.cellID)
    }
    
    
    func initalViewModel(){
       
        viewModel.reloadTableViewClosure = { [weak self] in
            guard  let self = self  else {return}
            DispatchQueue.main.async {
                self.mainView.favoriteTable.isHidden = false
                self.mainView.favoriteTable.reloadData()
            }
        }
        
        viewModel.emptyFavoriteCountClosure = { [weak self] in
            guard  let self = self  else {return}
            DispatchQueue.main.async {
                self.mainView.favoriteTable.isHidden = true
            }
        }
        
        
        viewModel.getProvidersFromRealmData()
        viewModel.checkFavoriteArrayCount()
    }
    
    func realmConfigration(){
        print("Realm File" , Realm.Configuration.defaultConfiguration.fileURL!)
        do {
            print( "realmObject:" , realm.objects(FavoriteModel.self))
        }
    }
}

extension FavoriteVC : UITableViewDelegate , UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCellForRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTabelCell.cellID, for: indexPath) as!
            FavoriteTabelCell
        let cellViewModel = viewModel.getCellViewModel(index: indexPath)
        cell.favoriteCellViewModel = cellViewModel
        cell.deleteFavoriteClosure = { [weak self] in
            guard  let self = self  else {return}
            self.viewModel.deleteMovieFromFav(index: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedMovieID = viewModel.gotoMoviesDetails(indexPath: indexPath)
        let vc = MoviesDetailsVC()
        vc.moviesID = selectedMovieID
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

