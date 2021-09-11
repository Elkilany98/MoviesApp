//
//  NowPlayingVC.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 09/09/2021.
//

import UIKit
import RealmSwift

class NowPlayingVC: UIViewController {
    
    var mainView : NowPlayingView {
        return view as! NowPlayingView
    }
    
    let realm = try! Realm()
    
    lazy var viewModel : NowPlayingViewModel = {
        return NowPlayingViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Now Playing"
        navigationController?.navigationBar.prefersLargeTitles = true
        print("Realm File" , Realm.Configuration.defaultConfiguration.fileURL!)
        tableViewConfigration()
        initNowPlayingViewModel()
    }
    
    func tableViewConfigration(){
        mainView.nowPlayingTable.delegate = self
        mainView.nowPlayingTable.dataSource = self
        mainView.nowPlayingTable.separatorStyle = .none
        mainView.nowPlayingTable.prefetchDataSource = self
        mainView.nowPlayingTable.register(NowPlayingTableCell.nib(), forCellReuseIdentifier: NowPlayingTableCell.cellID)
    }
    
    func initNowPlayingViewModel(){
        
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
        
        case .error , .isEmpty, .isEmptyResult:
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
                    self.mainView.nowPlayingTable.isHidden = true
                })
            }
            
        case.isGetData:
            mainView.progress.stopAnimating()
            DispatchQueue.main.async {
                print("print Stop Loading Progress")
                UIView.animate(withDuration: 0.2, animations: {
                    self.mainView.nowPlayingTable.isHidden = false
                })
            }
            
        case .isTypSearchText:
            return
            
        case .intervalError:
            return
        }
        
        
        viewModel.reloadTableViewClosure = { [weak self] in
            guard  let self = self  else {return}
            DispatchQueue.main.async {
                self.mainView.nowPlayingTable.reloadData()
            }
        }
        
        viewModel.getMoviesList()
        
    }
    
}

extension NowPlayingVC : UITableViewDelegate , UITableViewDataSource , UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCellForRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NowPlayingTableCell.cellID, for: indexPath) as!
            NowPlayingTableCell
        
        let cellViewModel = viewModel.getCellViewModel(index: indexPath)
        cell.nowPlayingCellViewModel = cellViewModel
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
        viewModel.paginateMoviesData(indexPaths: indexPaths)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedMovies = viewModel.gotoMoviesDetails(indexPath: indexPath)
        let vc = MoviesDetailsVC()
        vc.id = "\(selectedMovies.id ?? 0 )"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

