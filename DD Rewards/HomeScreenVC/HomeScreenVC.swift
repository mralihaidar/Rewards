//
//  HomeScreenVC.swift
//  DD Rewards
//
//  Created by Ali on 14/02/2023.
//

import UIKit
import MessageUI
import StoreKit
import Lottie
import AppLovinSDK
import MessageUI

class HomeScreenVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    var   termsAndConditionURL = "https://techboostapps.blogspot.com/p/terms-and-conditions-for-coin-master.html"
    var   privacyPolicyURL = "https://techboostapps.blogspot.com/p/privacy-policy-for-coin-master.html"
    var   helpAndSupportURL = "https://mail.google.com/mail/?view=cm&to=appsomagic@gmail.com"
    
    var addView: MAAdView!
    
    
    @IBOutlet weak var adViewHeightCostraint: NSLayoutConstraint!
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var homeAnimation: LottieAnimationView!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var homeTitleView: UIView!
    @IBOutlet var homeMainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var discLabel: UILabel!
    let homeString = ["Reward Links", "Games", "Rate the App", "Share", "Privacy Policy", "Help and Support"]
    let homeImages = ["gift.png", "console.png", "star.png", "share.png", "shield.png", "support.png"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeCollectionView.dataSource = self
        self.homeCollectionView.delegate = self
        
        homeCollectionView.register(UINib(nibName: "HomeCVC", bundle: nil), forCellWithReuseIdentifier: "HomeCVC")
        self.navigationController?.isNavigationBarHidden = true
        homeMainView.layer.cornerRadius = 10
        titleLabel.textColor = UIColor.black
        discLabel.textColor = UIColor.black
        setupAnimationView()
        decorateUI()
    }
    
    func decorateUI(){
        
        self.titleLabel.text = ProcessUtils.shared.titleName 
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (ProcessUtils.shared.IsAddShow == true){
            createBannerAd()
        }
    }
    
    func setupAnimationView () {
//        homeAnimation = LottieAnimationView(name: "coin")
        homeAnimation.contentMode = .scaleAspectFit
        homeAnimation.loopMode = .loop
        homeAnimation.animationSpeed = 0.7
        homeAnimation.play()
    }
}






extension HomeScreenVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCVC", for: indexPath) as! HomeCVC
        //let secData = homeString[indexPath.section]
        cell.cellLabel.text = homeString[indexPath.item]
        cell.cellImage.image = UIImage(named: homeImages[indexPath.item])
        //cell.backgroundColor = UIColor.green
        //cell.backgroundColor = UIColor.black
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (collectionView.frame.size.width - 80) / 2
        
        let cellHeight =  (collectionView.frame.size.height - 150) / 3
         
        return CGSize(width: cellWidth + 35, height: cellHeight)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if indexPath.item == 0 {
            
            let vc = RewardsListVC(nibName: "RewardsListVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.item == 1 {
            
            let vc = GamesListVC(nibName: "GamesListVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.item == 2 {
            
            guard let scene = view.window?.windowScene else {
                print("No Scene")
                return
            }
            if #available(iOS 14.0, *) {
                SKStoreReviewController.requestReview(in: scene)
            } else {
                // Fallback on earlier versions
            }
            
        } else if indexPath.item == 3 {
            
            let name = "Hey! Coin Master Fans,\n Are you out of spins and want more FREE spins then this is the right app for you!\nInstall the latest Coin Master Daily Rewards app and claim your daily FREE SPINS & COINS Now:- https://play.google.com/store/apps/details?id=com.mafiamasterfreespins.techboost"
            
              let objectsToShare = [name]
              let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
              self.present(activityVC, animated: true, completion: nil)

        } else if indexPath.item == 4 {
            
            
            let vc = WebViewVC(nibName: "WebViewVC", bundle: nil)
            vc.webLink = self.privacyPolicyURL
            self.navigationController?.pushViewController(vc, animated: true)

        } else if indexPath.item == 5 {
            self.sendEmail()
        }
        
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["appsomagic@gmail.com"])
//            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)

            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}


extension HomeScreenVC: MAAdViewAdDelegate {
    
    

       func createBannerAd()
       {
           
           addView = MAAdView(adUnitIdentifier: "YOUR_AD_UNIT_ID")
           addView.delegate = self
           addView.frame = CGRect(x: self.adView.frame.minX, y: self.adView.frame.minY, width: self.adView.frame.size.width, height: self.adView.frame.size.height)
           view.addSubview(addView)
       
           // Load the first ad
           addView.loadAd()
       }

       // MARK: MAAdDelegate Protocol

       func didLoad(_ ad: MAAd) {}

       func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {}

       func didClick(_ ad: MAAd) {}

       func didFail(toDisplay ad: MAAd, withError error: MAError) {}

       
       // MARK: MAAdViewAdDelegate Protocol

       func didExpand(_ ad: MAAd) {}

       func didCollapse(_ ad: MAAd) {}


       // MARK: Deprecated Callbacks

       func didDisplay(_ ad: MAAd) { /* use this for impression tracking */ }
       func didHide(_ ad: MAAd) { /* DO NOT USE - THIS IS RESERVED FOR FULLSCREEN ADS ONLY AND WILL BE REMOVED IN A FUTURE SDK RELEASE */ }
   }
