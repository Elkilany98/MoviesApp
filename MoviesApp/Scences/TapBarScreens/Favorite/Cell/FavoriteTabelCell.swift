//
//  FavoriteTabelCell.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 11/09/2021.
//

import UIKit

class FavoriteTabelCell: UITableViewCell {

    static let cellID = "FavoriteTabelCell"
    
    @IBOutlet weak var containerView:UIView!
    @IBOutlet weak var moviesImg:UIImageView!
    @IBOutlet weak var moviesTitleLab:UILabel!
    @IBOutlet weak var voteAverageLab:UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var deleteFavoriteClosure : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCellView()
    }
    
    static func nib()->UINib{
        return UINib(nibName: cellID, bundle: nil)
    }

    func setUpCellView(){
        deleteBtn.layer.cornerRadius = 12
        deleteBtn.layer.borderWidth = 1
        deleteBtn.layer.borderColor = #colorLiteral(red: 0.09411764706, green: 0.1568627451, blue: 0.5647058824, alpha: 1)
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
    
    
    @IBAction func deleteFavActionBtn(_ sender: Any) {
        deleteFavoriteClosure?()
    }
    
    
    var favoriteCellViewModel : FavoriteModel?  {
        didSet{
            moviesImg.kf.indicatorType = .activity
            moviesImg.kf.setImage(with:  URL(string: favoriteCellViewModel?.movieImage ?? "" ), placeholder: UIImage(named: "PlaceholderIMage"), options: .none)
            moviesTitleLab.text = favoriteCellViewModel?.movieTitle ?? ""
            voteAverageLab.text =  "Vote Average: " +  "\(favoriteCellViewModel?.movieVoteAverage ?? "")"
        }
    }
    
}
