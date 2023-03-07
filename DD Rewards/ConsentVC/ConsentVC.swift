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
    
    @IBOutlet weak var acceptView: UIView!
    @IBOutlet weak var btnAccept: UIButton!
    
    @IBOutlet weak var rejectView: UIView!
    @IBOutlet weak var btnReject: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblTitle.text = secreenTitle ?? ""
        self.headerView.backgroundColor = UIColor.themeColor
        lblDesc.text = "The \(self.secreenTitle ?? "")  URL will be opened outside the app. Do you agree that you want to leave the application and open the given URL outside the app now?"
        
        btnconsent.setImage(UIImage(systemName: "circle") , for: .normal)
        
//        btnAccept.layer.cornerRadius = btnAccept.frame.size.height/2
        btnAccept.backgroundColor = UIColor.themeColor
        btnReject.backgroundColor = UIColor.lightGray
//        btnReject.layer.cornerRadius = btnReject.frame.size.height/2
        acceptView.layer.cornerRadius = acceptView.frame.size.height/2
        rejectView.layer.cornerRadius = rejectView.frame.size.height/2
        acceptView.backgroundColor = UIColor.themeColor
        rejectView.backgroundColor = UIColor.lightGray
//        btnconsent.setImage(UIImage(named: "circle") , for: .normal)
    }
    
    
    
    @IBAction func acceptTapped(_ sender: Any) {
        if isShow{
            UserDefaults.standard.setValue("0", forKey: "isConsentShow")
        }
        
        if let cb = callback {
            cb(true)
        }
        
        self.dismiss(animated: true)
    }
    
    @IBAction func rejectTapped(_ sender: Any) {
//        if let cb = callback {
//            cb(false)
//        }
        self.dismiss(animated: true)
    }
    
    @IBAction func selectConsentTapped(_ sender: Any) {
    
        if (isShow){
            isShow = false
            btnconsent .setImage(UIImage(systemName: "circle") , for: .normal)
        }else{
            isShow = true
            btnconsent .setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }
        
        
    }
    
    
    
    
    
    

    var panScrollable: UIScrollView? {
            return nil
    }
    
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(380)
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(380)
    }
}
