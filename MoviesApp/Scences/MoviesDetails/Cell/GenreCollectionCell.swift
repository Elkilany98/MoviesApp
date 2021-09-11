//
//  GenreCollectionCell.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 11/09/2021.
//

import UIKit

class GenreCollectionCell: UICollectionViewCell {
    
    static let cellID = "GenreCollectionCell"
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var generLab: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 12
        containerView.layer.borderColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        containerView.layer.borderWidth = 1.0
    }
    
    static func nib()->UINib{
        return UINib(nibName: cellID, bundle: nil)
    }
    
    var cellViewModel : GenerCellViewModel?   {
        didSet  {
            generLab.text = cellViewModel?.name ?? ""
        }
        
    }

}
