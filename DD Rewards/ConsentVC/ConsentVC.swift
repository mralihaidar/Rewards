//
//  ConsentVC.swift
//  DD Rewards
//
//  Created by Umair Yousaf on 28/02/2023.
//

import UIKit

import PanModal

class ConsentVC: UIViewController , PanModalPresentable{
    
    var secreenTitle : String?
    var isShow = true
    var callback : ((Bool) -> Void)?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var headerView: UIView!

    
    @IBOutlet weak var btnconsent: UIButton!
    @IBOutlet weak var lblDesc: UITextView!
    
    @IBOutlet weak var btnAccept: UIButton!
    
    @IBOutlet weak var btnReject: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblTitle.text = secreenTitle ?? ""
        self.headerView.backgroundColor = UIColor.themeColor
        lblDesc.text = "I got \(self.secreenTitle ?? "") from this application, try Mafiaa Master Daily Rewards App Now: https://play.google.com/store/apps/details?id=com.mafiamasterfreespins.techboost"
        
        
        btnconsent .setImage(UIImage(named: "circle") , for: .normal)
    }
    
    
    
    @IBAction func acceptTapped(_ sender: Any) {
        if isShow{
            UserDefaults.standard.setValue(false, forKey: "isConsentShow")
        }
        
        if let cb = callback {
            cb(true)
        }
        
        self.dismiss(animated: true)
    }
    
    @IBAction func rejectTapped(_ sender: Any) {
        if let cb = callback {
            cb(false)
        }
        self.dismiss(animated: true)
    }
    
    @IBAction func selectConsentTapped(_ sender: Any) {
    
        if (isShow){
            isShow = false
            btnconsent .setImage(UIImage(named: "circle") , for: .normal)
        }else{
            isShow = true
            btnconsent .setImage(UIImage(named: "checkmark.circle.fill"), for: .normal)
        }
        
        
    }
    
    
    
    
    
    

    var panScrollable: UIScrollView? {
            return nil
    }
    
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(400)
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(400)
    }
}
