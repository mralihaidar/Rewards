//
//  TipDetailVC.swift
//  CM Rewards
//
//  Created by Umair Yousaf on 01/04/2023.
//

import UIKit

class TipDetailVC: UIViewController {

    var titleText : String?
    var descText : String?
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var descView: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        decorateUI()
    }


    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func decorateUI(){
        titleView.layer.cornerRadius = 10
        descView.layer.cornerRadius = 10
        
        self.lblTitle.text = titleText
        self.lblDesc.text = descText
        
    }
    
}
