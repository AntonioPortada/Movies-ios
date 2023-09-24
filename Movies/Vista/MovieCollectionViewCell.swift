//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Antonio Portada on 21/09/23.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOulet
    @IBOutlet weak var posterMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var dateMovie: UILabel!
    @IBOutlet weak var descriptionMovie: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
