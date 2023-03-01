//
//  DetailVC.swift
//  DD Rewards
//
//  Created by Ali on 06/02/2023.
//

import UIKit
import Lottie
import AppLovinSDK
import PanModal

class DetailVC: UIViewController {
    //private var animationView: LottieAnimationView?
    var gameListTitle = ""
    var gameListDate = ""
    var gameListReward = ""
    var isRedeemCode : Bool = false
    var redeemCode = ""
    var gameTitle = ""
    
    var dataModel: Rewards?
    
    var nativeAdLoader: MANativeAdLoader?
    var nativeAd: MAAd?
    var nativeAdView: UIView?
    
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var secondSection: UIView!
    @IBOutlet weak var firstSection: UIView!
    @IBOutlet weak var sectionDiscText: UILabel!
    @IBOutlet weak var collectBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var sectionDateText: UILabel!
    @IBOutlet weak var sectionTitleText: UILabel!
    @IBOutlet weak var emojiImg: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var adView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        
        mainView.backgroundColor = UIColor.themeColor
        backButton.tintColor = UIColor.white
        titleText.textColor = UIColor.white
        shareBtn.layer.cornerRadius = 10
        collectBtn.layer.cornerRadius = 10
        //firstSection.layer.cornerRadius = 10
        secondSection.layer.borderColor = UIColor.systemGray6.cgColor
        secondSection.layer.borderWidth = 2
        secondSection.layer.cornerRadius = 10
        secondSection.layer.shadowColor = UIColor.black.cgColor
        //secondSection.layer.shadowOpacity = 0.2
        secondSection.layer.shadowRadius = 2
        secondSection.layer.shadowOffset = CGSize(width: 0, height: 2)
        animationView.backgroundColor = UIColor.hexString(hex: "874BFF")
        animationView.layer.cornerRadius = 10
        sectionTitleText.text = gameListTitle
        let dateFormated = DateFormatManager.shared.formatDateStrToStr(date: gameListDate , oldFormat: "dd-mm-yy", newFormat: "dd MMM yyyy")
        sectionDateText.text = dateFormated
        setupAnimationView()
        createNativeAd()
        titleText.text = "Collect Your Daily Reward"
    }
    
    func setContent(dataModel: Rewards){
        self.dataModel = dataModel
        redeemCode = dataModel.id ?? ""
        gameTitle = dataModel.title ?? ""
        let gameDate = dataModel.date
        let gameRewardURL = dataModel.reward_url

        self.gameListTitle = gameTitle
        self.gameListDate = gameDate ?? ""
        self.gameListReward = gameRewardURL ?? ""
        
    }
    
    func setupAnimationView () {
          animationView.contentMode = .scaleAspectFit
          animationView.loopMode = .loop
          animationView.animationSpeed = 0.7
          animationView.play()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareBtnPressed(_ sender: UIButton) {
        
        let name = "I got \(dataModel?.title ?? "") from this application, try Coin Master Daily Rewards App Now: https://play.google.com/store/apps/details?id=com.mafiamasterfreespins.techboost"
          let objectsToShare = [name]
          let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
          self.present(activityVC, animated: true, completion: nil)
        
    }
    
    @IBAction func collectBtnPressed(_ sender: UIButton) {
        
        if (UserDefaults.standard.isConsentShow == "1" ){
            self.collectReward()
        }else{
            let vc  = ConsentVC(nibName: "ConsentVC", bundle: nil)
            vc.secreenTitle = dataModel?.title
            vc.callback = { (added) in
                DispatchQueue.main.async {
                    self.collectReward()
                }
            }
            self.presentPanModal(vc)
        }
    }
    
    func collectReward(){
        if self.dataModel?.is_redeem_code == "1"{
            presentModal()
        }else{
            if let url = URL(string: self.dataModel?.reward_url ?? ""){
                if self.dataModel?.is_game_link == "1"{
                    if let urlScheme = URL(string: "coinmaster://"){
                        if UIApplication.shared.canOpenURL(urlScheme) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }else{
                            let alert = UIAlertController(title: "Alert", message: "Please Install Coin Master app to collect reward", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                return
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }else{
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
        }
    }
 
    func presentModal() {
        let vc = CollectRewardVC(nibName: "CollectRewardVC", bundle: nil)
        vc.secreenTitle = gameTitle
        vc.code = redeemCode
        presentPanModal(vc)

    }
}


extension DetailVC : MANativeAdDelegate
{
    func didLoadNativeAd(_ nativeAdView: MANativeAdView?, for ad: MAAd) {
        // Clean up any pre-existing native ad to prevent memory leaks
        if let currentNativeAd = nativeAd
        {
            nativeAdLoader?.destroy(currentNativeAd)
        }

        // Save ad for cleanup
        nativeAd = ad
        
        if let currentNativeAdView = self.nativeAdView
        {
            currentNativeAdView.removeFromSuperview()
        }
        
        // Add ad view to view
        self.nativeAdView = nativeAdView;
        guard let nativeAdView = nativeAdView else { return }
        self.adView.addSubview(nativeAdView)
//        self.adView.addSubView(nativeAdView)
        
        // Set to false if modifying constraints after adding the ad view to your layout
        nativeAdView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the native ad view to your layout
        adView.addSubview(nativeAdView)
        
        // Set ad view to span width and height of container and center the ad
        adView.addConstraint(NSLayoutConstraint(item: nativeAdView,
                                                               attribute: .width,
                                                               relatedBy: .equal,
                                                               toItem: adView,
                                                               attribute: .width,
                                                               multiplier: 1,
                                                               constant: 0))
        adView.addConstraint(NSLayoutConstraint(item: nativeAdView,
                                                               attribute: .height,
                                                               relatedBy: .equal,
                                                               toItem: adView,
                                                               attribute: .height,
                                                               multiplier: 1,
                                                               constant: 0))
        adView.addConstraint(NSLayoutConstraint(item: nativeAdView,
                                                               attribute: .centerX,
                                                               relatedBy: .equal,
                                                               toItem: adView,
                                                               attribute: .centerX,
                                                               multiplier: 1,
                                                               constant: 0))
        adView.addConstraint(NSLayoutConstraint(item: nativeAdView,
                                                               attribute: .centerY,
                                                               relatedBy: .equal,
                                                               toItem: adView,
                                                               attribute: .centerY,
                                                               multiplier: 1,
                                                               constant: 0))
    }
    
    
    func createNativeAd()
        {
            nativeAdLoader = MANativeAdLoader(adUnitIdentifier: "YOUR_AD_UNIT_ID")
            nativeAdLoader?.nativeAdDelegate = self
            nativeAdLoader?.loadAd()
        }
    func didLoadNativeAdView(_ nativeAdView: MANativeAdView?, for ad: MAAd)
    {
        
    }
    
    func didFailToLoadNativeAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError)
    {
        // We recommend retrying with exponentially higher delays up to a maximum delay
    }
    
    func didClickNativeAd(_ ad: MAAd)
    {
        // Optional click callback
    }
}
