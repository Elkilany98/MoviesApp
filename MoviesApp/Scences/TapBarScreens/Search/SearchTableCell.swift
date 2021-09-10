//
//  SearchTableCell.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 10/09/2021.
//

import UIKit

class SearchTableCell: UITableViewCell {

  
    static let cellID = "SearchTableCell"
    
    @IBOutlet weak var containerView:UIView!
    @IBOutlet weak var moviesImg:UIImageView!
    @IBOutlet weak var moviesTitleLab:UILabel!
    @IBOutlet weak var voteAverageLab:UILabel!
    @IBOutlet weak var favouritImg:UIImageView!

    var favoriteImageClosure : (()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCellView()
    }
    
    static func nib()->UINib{
        return UINib(nibName: cellID, bundle: nil)
    }

    func setUpCellView(){
        favoriteAction()
        favouritImg.image = UIImage(named: "emptyFav")
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
    
    
    func favoriteAction(){
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(favoriteImageTapped))
        favouritImg.isUserInteractionEnabled = true
        favouritImg.addGestureRecognizer(tap)
    }
    
    @objc func favoriteImageTapped(){
        if favouritImg.image == UIImage(named: "redFav"){
            favouritImg.image =  UIImage(named: "emptyFav")
        }else{
            favouritImg.image =  UIImage(named: "redFav")
        }
        favoriteImageClosure?()
    }
    
    var searchCellViewModel : GeneralCellViewModel?  {
        didSet{
            moviesImg.kf.indicatorType = .activity
            moviesImg.kf.setImage(with:  URL(string: searchCellViewModel?.backdropPath ?? "" ), placeholder: UIImage(named: "PlaceholderIMage"), options: .none)
            moviesTitleLab.text = searchCellViewModel?.originalTitle ?? ""
            voteAverageLab.text =  "Vote Average: " +  "\(searchCellViewModel?.voteAverage ?? 0.0)"
        }
    }
    
}
