//
//  PrivacyPolicyVC.swift
//  DD Rewards
//
//  Created by Ali on 23/02/2023.
//

import UIKit
import DLRadioButton
class PrivacyPolicyVC: UIViewController {
    
    var privacySelected : Bool = false

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
        privacyPolicyAcceptBtn.backgroundColor = UIColor.themeColor
        privacyPolicyAcceptBtn.tintColor = .white
        privacyPolicyAcceptBtn.layer.cornerRadius = 10
    }
    
    @IBAction func radioButtonPressed(_ sender: UIButton) {
        if privacySelected {
            radioBtn.isSelected = false
            privacySelected = false
        }else{
            radioBtn.isSelected = sender.isSelected
            privacySelected = true
        }
        
    }
    @IBAction func privacyPolicyAcceptBtnPressed(_ sender: UIButton) {
        if radioBtn.isSelected {
            UserDefaults.standard.setValue(1, forKey: "PrivacyPolicyAccept")
            let vc = HomeScreenVC(nibName: "HomeScreenVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
