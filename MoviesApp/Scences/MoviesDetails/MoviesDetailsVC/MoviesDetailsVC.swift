//
//  MoviesDetailsVC.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 11/09/2021.
//

import UIKit

class MoviesDetailsVC: UIViewController {
    
    var moviesID = ""
    
    lazy var viewModel : MoviesDetailsViewModel = {
        return MoviesDetailsViewModel()
    }()
    
    var mainView : MoviesDetailsView {
        return view as! MoviesDetailsView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      print("SelectedMoviesID: on details" , moviesID)
        setUpView()
        generCollections()
        initNowPlayingViewModel()
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
                    case .isLoading,.isGetData,.isTypSearchText:
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
                    self.mainView.containerView.isHidden = true
                })
            }
            
        case.isGetData:
            mainView.progress.stopAnimating()
            DispatchQueue.main.async {
                print("print Stop Loading Progress")
                UIView.animate(withDuration: 0.2, animations: {
                    self.mainView.containerView.isHidden = true
                })
            }
        case .isTypSearchText,.intervalError:
            return
        }
        
        
        viewModel.reloadTableViewClosure = { [weak self] in
            guard  let self = self  else {return}
            DispatchQueue.main.async {
                self.mainView.genersCollection.reloadData()
            }
        }
        
        
        viewModel.moviesDetailsClosure = {  [weak self]  (moviesData) in
            guard  let self = self  else {return}
        let urlPathImage = ("https://image.tmdb.org/t/p/w500" + (moviesData.backdropPath ?? "" ))
            self.mainView.moviesImg.kf.setImage(with: URL(string: urlPathImage))
            self.mainView.titleLab.text = moviesData.originalTitle ?? ""
            self.mainView.descriptionLab.text = moviesData.overview ?? ""
            self.mainView.relaseDateLab.text = moviesData.releaseDate ?? ""
            self.mainView.voteCountLab.text = "Vote Count: " + "\(moviesData.voteCount ?? 0.0)"
            self.mainView.voteAverageLab.text = "Vote Average: " + "\(moviesData.voteAverage ?? 0.0)"
        }
        viewModel.getMoviesDetailsList(moviesID: self.moviesID)
        
    }
    
    func setUpView(){
        mainView.containerView.layer.cornerRadius = 50
        mainView.containerView.layer.maskedCorners = [.layerMaxXMinYCorner ,.layerMinXMinYCorner]
        mainView.backBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
    }
    
    @objc func backBtnTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func generCollections(){
        let minimumItemSpacing:CGFloat = 20
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = minimumItemSpacing
        flowLayout.scrollDirection = .horizontal
        mainView.genersCollection.collectionViewLayout = flowLayout
        mainView.genersCollection.delegate = self
        mainView.genersCollection.dataSource = self
        mainView.genersCollection.showsHorizontalScrollIndicator = false
        mainView.genersCollection.register(UINib(nibName: GenreCollectionCell.cellID, bundle: nil), forCellWithReuseIdentifier: GenreCollectionCell.cellID)
    }

    
}


extension MoviesDetailsVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCellForRow
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionCell.cellID, for: indexPath) as! GenreCollectionCell
        let cellViewModel = viewModel.getCellViewModel(index: indexPath)
        cell.cellViewModel = cellViewModel
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = (viewModel.generList[indexPath.row].name! as NSString).size(withAttributes: nil)
                 size.width += 70
                 size.height = 50
                 return size
    }
    
    
    
}
