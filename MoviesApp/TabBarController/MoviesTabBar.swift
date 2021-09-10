//
//  MoviesTabBar.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 09/09/2021.
//

import UIKit

class MoviesTabBar: UITabBarController , UITabBarControllerDelegate {
    
       override func viewDidLoad() {
           super.viewDidLoad()
           self.delegate = self
           configureTabBarForNoCustom()
       }
        

    func configureTabBarForNoCustom(){

        let tabBarAppearence = UITabBarItem.appearance()
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.09411764706, green: 0.1568627451, blue: 0.5647058824, alpha: 1)
        self.tabBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let attribute = [NSAttributedString.Key.font:UIFont(name: "Cairo Bold", size: 12)]
        tabBarAppearence.setBadgeTextAttributes(attribute as [NSAttributedString.Key : Any], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(attribute as [NSAttributedString.Key : Any], for: .normal)

        
        viewControllers = [nowPlayingNC(),topRatedNC(),searchNC(),favoriteNC() ]
        //, childNC(),tasksNC(),statisticsNC()
    }

    func nowPlayingNC() -> UINavigationController{
        let nowPlayingVC = NowPlayingVC()
        nowPlayingVC.tabBarItem = UITabBarItem(title: "Now Playing", image: UIImage(named: "videoTap"), tag: 0)
        return self.returnBerryNavigationController(rootVC: nowPlayingVC)
    }

        func topRatedNC() -> UINavigationController {
        let topRatedVC = TopRatedVC()
        topRatedVC.tabBarItem = UITabBarItem(title: "Top Rated", image: UIImage(named: "ratingsTap"), tag: 1)
        return self.returnBerryNavigationController(rootVC: topRatedVC)
    }

    func searchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "searchTap"), tag: 2)
        return self.returnBerryNavigationController(rootVC: searchVC)
    }

    func favoriteNC() -> UINavigationController {
        let favoriteVC = FavoriteVC()
        favoriteVC.tabBarItem = UITabBarItem(title: "Favourite", image: UIImage(named: "favouriteTab"), tag: 3)
        return self.returnBerryNavigationController(rootVC: favoriteVC)
    }
    
   
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            guard let viewControllers = viewControllers else { return false }
            if viewController == viewControllers[selectedIndex] {
                if let nav = viewController as? UINavigationController {
                    guard let topController = nav.viewControllers.last else { return true }
                    if !topController.isScrolledToTop {
                        topController.scrollToTop()
                        return false
                    } else {
                        nav.popViewController(animated: true)
                    }
                    return true
                }
            }
            return true
        }
}

extension UITabBarController {
    
    
    func returnBerryNavigationController(rootVC:UIViewController)-> UINavigationController {
        
        let nc = UINavigationController(rootViewController: rootVC)
        nc.navigationBar.titleTextAttributes = [.font:UIFont(name: "Cairo Bold", size: 16) ?? "",.foregroundColor: UIColor(named: "182890") as Any]
        nc.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        nc.modalPresentationStyle = .fullScreen
        nc.modalTransitionStyle = .crossDissolve
//        nc.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        nc.navigationBar.shadowImage = UIImage()
                return nc
        
    }
}

