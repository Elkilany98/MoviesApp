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
        gotoTabBar()
    }
    
    func setUpView(){
        mainView.evaLogoImg.layer.cornerRadius = mainView.evaLogoImg.layer.frame.height / 2
    }
    
     func setTabBarAsRoot() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let moviesTabBar = MoviesTabBar()
        moviesTabBar.selectedIndex = 0
        appDelegate.window!.rootViewController = moviesTabBar
    }
    
    func gotoTabBar(){
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
            self.setTabBarAsRoot()
        }
        
    }
    
    
    
}
