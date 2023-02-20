//
//  GamesCVC.swift
//  DD Rewards
//
//  Created by Ali on 15/02/2023.
//

import UIKit

class GamesCVC: UICollectionViewCell {

    @IBOutlet weak var gameCellTextLabel: UILabel!
    @IBOutlet weak var gameCellText: UIView!
    @IBOutlet weak var gameImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        gameImg.layer.cornerRadius = 10
        gameImg.layer.masksToBounds = true
    }

}
