//
//  SplashVC.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 09/09/2021.
//

import UIKit

class SplashVC: UIViewController {
    
    var mainView : SplashView {
        return view as! SplashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView(){
        mainView.evaLogoImg.layer.cornerRadius = mainView.evaLogoImg.layer.frame.height / 2
    }
}
