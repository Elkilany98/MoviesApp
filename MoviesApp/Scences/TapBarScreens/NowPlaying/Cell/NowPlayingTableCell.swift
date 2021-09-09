//
//  NowPlayingTableCell.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 10/09/2021.
//

import UIKit

class NowPlayingTableCell: UITableViewCell {

    static let cellID = "NowPlayingTableCell"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var moviesImg: UIImageView!
    @IBOutlet weak var moviesTitleLab: UILabel!
    @IBOutlet weak var voteAverageLab : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCellView()
    }
    
    static func nib()->UINib{
        return UINib(nibName: cellID, bundle: nil)
    }
    
    func setUpCellView(){
        moviesImg.layer.cornerRadius = 18
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.darkGray.cgColor
        containerView.layer.shadowOpacity = 0.35
        containerView.layer.shadowRadius = 5
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        containerView.layer.masksToBounds = false
        selectionStyle = .none
    }

}
