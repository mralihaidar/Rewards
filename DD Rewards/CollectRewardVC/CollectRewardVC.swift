//
//  CollectRewardVC.swift
//  DD Rewards
//
//  Created by Umair Yousaf on 24/02/2023.
//

import UIKit
import PanModal

class CollectRewardVC: UIViewController , PanModalPresentable{
    
    var code : String?
    var secreenTitle : String?
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var btnRedeem: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblTitle.text = secreenTitle ?? ""
        self.headerView.backgroundColor = UIColor.themeColor
    }
    
    
    
    @IBAction func redeemTapped(_ sender: Any) {
        
        
        UIPasteboard.general.string = self.code
        showToast(message: "Code Copied")
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

    func showToast(message : String ) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-150, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        toastLabel.textColor = UIColor.white
//        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
 

}
