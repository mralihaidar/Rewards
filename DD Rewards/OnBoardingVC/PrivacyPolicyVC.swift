//
//  PrivacyPolicyVC.swift
//  DD Rewards
//
//  Created by Ali on 23/02/2023.
//

import UIKit
import DLRadioButton
class PrivacyPolicyVC: UIViewController, UITextViewDelegate {
    
    var privacySelected : Bool = false

    @IBOutlet weak var radioBtn: DLRadioButton!
    @IBOutlet weak var privacyPolicyAcceptBtn: UIButton!
    @IBOutlet weak var textView: UILabel!
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
    
        let attributedString = NSMutableAttributedString(string: "I have read the privacy terms carefully and agree to the Privacy Policy")
                attributedString.addAttribute(.link, value: "https://appsomagic.blogspot.com/p/privacy-policy-for-coin-master.html", range: NSRange(location: 57, length: 14))
        textView.attributedText = attributedString
        textView.font = .systemFont(ofSize: 16)


    }
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
            UIApplication.shared.open(URL)
            return false
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
        }else{
            let alert = UIAlertController(title: "Alert", message: "You need to accept privacy policy", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title:  "Dismiss ", style: .cancel, handler: nil))
                                self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}
