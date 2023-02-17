//
//  PhotoCellCollectionViewCell.swift
//  VenturusChallenge
//
//  Created by Marcelo Carvalho on 17/02/23.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }

}

extension UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
