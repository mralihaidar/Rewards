//
//  TipTVC.swift
//  CM Rewards
//
//  Created by Umair Yousaf on 01/04/2023.
//

import UIKit

class TipTVC: UITableViewCell {

    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func decorateUI(){
        self.mainView.layer.cornerRadius = 10

    }
    
    
    
    
    
}
