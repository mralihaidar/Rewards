//
//  GamesCVC.swift
//  DD Rewards
//
//  Created by Ali on 15/02/2023.
//

import UIKit

class GamesCVC: UICollectionViewCell {

    @IBOutlet weak var gameCellText: UIView!
    @IBOutlet weak var gameImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        gameImg.layer.cornerRadius = 8
        gameImg.layer.masksToBounds = true
    }

}
