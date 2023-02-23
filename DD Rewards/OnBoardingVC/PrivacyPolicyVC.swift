//
//  PrivacyPolicyVC.swift
//  DD Rewards
//
//  Created by Ali on 23/02/2023.
//

import UIKit
import DLRadioButton
class PrivacyPolicyVC: UIViewController {

    @IBOutlet weak var radioBtn: DLRadioButton!
    @IBOutlet weak var privacyPolicyAcceptBtn: UIButton!
    @IBOutlet weak var privacyPolicyCheckLabel: UILabel!
    @IBOutlet weak var privacyPolicyCheckImage: UIImageView!
    @IBOutlet weak var privacyPolicyCenterImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        privacyPolicyCenterImage.layer.cornerRadius = 25
        privacyPolicyAcceptBtn.backgroundColor = UIColor.hexString(hex: "004aad")
        privacyPolicyAcceptBtn.tintColor = .white
        privacyPolicyAcceptBtn.layer.cornerRadius = 10
    }
    
    @IBAction func radioButtonPressed(_ sender: UIButton) {
        radioBtn.isSelected = sender.isSelected
        print("radio button pressed")
    }
    @IBAction func privacyPolicyAcceptBtnPressed(_ sender: UIButton) {
        if radioBtn.isSelected {
            let vc = HomeScreenVC(nibName: "HomeScreenVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
