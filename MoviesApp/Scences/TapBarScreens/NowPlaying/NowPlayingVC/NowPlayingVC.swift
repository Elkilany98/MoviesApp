//
//  NowPlayingVC.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 09/09/2021.
//

import UIKit

class NowPlayingVC: UIViewController {
    
    var mainView : NowPlayingView {
        return view as! NowPlayingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.nowPlayingTable.delegate = self
        mainView.nowPlayingTable.dataSource = self
        mainView.nowPlayingTable.separatorStyle = .none
        mainView.nowPlayingTable.showsVerticalScrollIndicator = false 
        mainView.nowPlayingTable.register(NowPlayingTableCell.nib(), forCellReuseIdentifier: NowPlayingTableCell.cellID)
        title = "Now Playing"
    }
}

extension NowPlayingVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NowPlayingTableCell.cellID, for: indexPath) as!
            NowPlayingTableCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    
}
