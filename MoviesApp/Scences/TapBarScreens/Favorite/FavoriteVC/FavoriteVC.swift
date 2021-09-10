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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmConfigration()
    }
    
    func realmConfigration(){
        print("Realm File" , Realm.Configuration.defaultConfiguration.fileURL!)
        do {
            print( "realmObject:" , realm.objects(FavoriteModel.self))
        }
    }
}
