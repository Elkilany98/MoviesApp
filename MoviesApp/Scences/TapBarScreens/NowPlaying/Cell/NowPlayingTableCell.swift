//
//  NowPlayingTableCell.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 10/09/2021.
//

import UIKit
import Kingfisher



class NowPlayingTableCell: UITableViewCell {

    static let cellID = "NowPlayingTableCell"
    
    @IBOutlet weak var containerView:UIView!
    @IBOutlet weak var moviesImg:UIImageView!
    @IBOutlet weak var moviesTitleLab:UILabel!
    @IBOutlet weak var voteAverageLab:UILabel!
    @IBOutlet weak var favBtn: UIButton!
    
    var favoriteImageClosure : (()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCellView()
    }
    
    static func nib()->UINib{
        return UINib(nibName: cellID, bundle: nil)
    }
  

    func setUpCellView(){
        favBtn.layer.cornerRadius = 12
        favBtn.layer.borderWidth = 1
        favBtn.layer.borderColor = #colorLiteral(red: 0.09411764706, green: 0.1568627451, blue: 0.5647058824, alpha: 1)
        moviesImg.layer.cornerRadius = 22
        containerView.layer.cornerRadius = 22
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
            isHidden = false
            isSelected = false
            isHighlighted = false
    }
    
    
    @IBAction func favActionBtn(_ sender: Any) {
                favoriteImageClosure?()
    }
    
    
    var nowPlayingCellViewModel : GeneralCellViewModel?  {
        didSet{
            moviesImg.kf.indicatorType = .activity
            moviesImg.kf.setImage(with:  URL(string: nowPlayingCellViewModel?.backdropPath ?? "" ), placeholder: UIImage(named: "PlaceholderIMage"), options: .none)
            moviesTitleLab.text = nowPlayingCellViewModel?.originalTitle ?? ""
            voteAverageLab.text =  "Vote Average: " +  "\(nowPlayingCellViewModel?.voteAverage ?? 0.0)"
        }
    }
    
}
