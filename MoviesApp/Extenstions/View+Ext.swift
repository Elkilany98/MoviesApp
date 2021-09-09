//
//  View+Ext.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 10/09/2021.
//

import UIKit
 

class ShadowView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        configureContainerView()
    }

    func configureContainerView(){
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.35
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.masksToBounds = false
    }

}
