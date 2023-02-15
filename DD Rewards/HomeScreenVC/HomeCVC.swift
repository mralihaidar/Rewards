//
//  HomeCVC.swift
//  DD Rewards
//
//  Created by Ali on 14/02/2023.
//

import UIKit

class HomeCVC: UICollectionViewCell {

    @IBOutlet weak var collectionCellView: UIView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionCellView.backgroundColor = UIColor.systemGray6
        collectionCellView.layer.cornerRadius = 8
    }

}
