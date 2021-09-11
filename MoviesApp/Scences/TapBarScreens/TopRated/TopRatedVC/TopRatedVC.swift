//
//  TopRatedVC.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 09/09/2021.
//

import UIKit
import RealmSwift

class TopRatedVC: UIViewController {
    
    var mainView : TopRatedView {
        return view as! TopRatedView
    }
    let realm = try! Realm()

    lazy var viewModel : TopRatedViewModel = {
        return TopRatedViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Rated"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableViewConfigration()
        initTopRatedViewModel()
    }
    
    func tableViewConfigration(){
        mainView.topRatedTable.delegate = self
        mainView.topRatedTable.dataSource = self
        mainView.topRatedTable.separatorStyle = .none
        mainView.topRatedTable.showsVerticalScrollIndicator = false
        mainView.topRatedTable.prefetchDataSource = self
        mainView.topRatedTable.register(TopRatedTableCell.nib(), forCellReuseIdentifier: TopRatedTableCell.cellID)
    }
    
    func initTopRatedViewModel(){
        
        viewModel.showAlertClosure = { [weak self] in
            guard  let self = self  else {return}
            DispatchQueue.main.async {
                if let message = self.viewModel.alertMessage{
                    self.showAlert(message)
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
                    self.mainView.topRatedTable.isHidden = true
                })
            }
            
        case.isGetData:
            mainView.progress.stopAnimating()
            DispatchQueue.main.async {
                print("print Stop Loading Progress")
                UIView.animate(withDuration: 0.2, animations: {
                    self.mainView.topRatedTable.isHidden = false
                })
            }
        case .isTypSearchText:
            return
        }
        
        
        viewModel.reloadTableViewClosure = { [weak self] in
            guard  let self = self  else {return}
            DispatchQueue.main.async {
                self.mainView.topRatedTable.reloadData()
            }
        }
        viewModel.getTopRatedList()
    }
    
}

extension TopRatedVC : UITableViewDelegate , UITableViewDataSource , UITableViewDataSourcePrefetching {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCellForRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopRatedTableCell.cellID, for: indexPath) as!
            TopRatedTableCell
        let cellViewModel = viewModel.getCellViewModel(index: indexPath)
        cell.topRatedCellViewModel = cellViewModel
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
    
}
