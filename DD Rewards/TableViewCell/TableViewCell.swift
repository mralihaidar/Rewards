//
//  TableViewCell.swift
//  DD Rewards
//
//  Created by Ali on 06/02/2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var topDateLbl: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var TVCell: UIView!
    @IBOutlet weak var cellBackArrow: UIButton!
    @IBOutlet weak var cellDateLbl: UILabel!
    @IBOutlet weak var cellTitleLbl: UILabel!
    @IBOutlet weak var cellImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellImg.layer.borderWidth = 1
        cellImg.layer.borderColor = UIColor.hexString(hex: "E2630B").cgColor
        cellImg.layer.cornerRadius = 10
        //cellView.layer.borderWidth = 1
        cellView.layer.cornerRadius = 10
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOpacity = 0.23
        cellView.layer.shadowRadius = 2
        cellView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cellBackArrow.tintColor = UIColor.hexString(hex: "E2630B")
        //topDateLbl.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
