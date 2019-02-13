//
//  PhotoCollectionViewCell.swift
//  10YearChallenge
//
//  Created by Chang Sophia on 2/5/19.
//  Copyright © 2019 Chang Sophia. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var imageURL: URL!
}
