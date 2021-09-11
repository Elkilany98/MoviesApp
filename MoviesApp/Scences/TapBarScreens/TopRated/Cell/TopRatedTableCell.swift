//
//  TopRatedTableCell.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 10/09/2021.
//

import UIKit

class TopRatedTableCell: UITableViewCell {

    static let cellID = "TopRatedTableCell"
    
    @IBOutlet weak var containerView:UIView!
    @IBOutlet weak var moviesImg:UIImageView!
    @IBOutlet weak var moviesTitleLab:UILabel!
    @IBOutlet weak var voteAverageLab:UILabel!
    @IBOutlet weak var favouritBtn:UIButton!

    var favoriteClosure : (()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCellView()
    }
    
    static func nib()->UINib{
        return UINib(nibName: cellID, bundle: nil)
    }

    func setUpCellView(){
        favouritBtn.layer.cornerRadius = 12
        favouritBtn.layer.borderWidth = 1
        favouritBtn.layer.borderColor = #colorLiteral(red: 0.09411764706, green: 0.1568627451, blue: 0.5647058824, alpha: 1)
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
        favoriteClosure?()
    }
    
    
    
    var topRatedCellViewModel : GeneralCellViewModel?  {
        didSet{
            moviesImg.kf.indicatorType = .activity
            moviesImg.kf.setImage(with:  URL(string: topRatedCellViewModel?.backdropPath ?? "" ), placeholder: UIImage(named: "PlaceholderIMage"), options: .none)
            moviesTitleLab.text = topRatedCellViewModel?.originalTitle ?? ""
            voteAverageLab.text =  "Vote Average: " +  "\(topRatedCellViewModel?.voteAverage ?? 0.0)"
        }
    }
}
