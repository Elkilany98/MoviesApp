//
//  MoviesDetailsVC.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 11/09/2021.
//

import UIKit

class MoviesDetailsVC: UIViewController {
    
    var id = ""
    
    
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
        print("id:" ,id)
        mainView.containerView.layer.cornerRadius = 50
        mainView.containerView.layer.shadowColor = UIColor.black.cgColor
        mainView.containerView.layer.shadowOpacity = 0.45
        mainView.containerView.layer.shadowRadius = 5
        mainView.containerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        mainView.containerView.layer.masksToBounds = false
        
    }
}
