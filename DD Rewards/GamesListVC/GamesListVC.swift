//
//  GamesListVC.swift
//  DD Rewards
//
//  Created by Ali on 15/02/2023.
//

import UIKit
import SDWebImage
import AppLovinSDK


class GamesListVC: UIViewController {
    var gameList: [games] = []
   // var gName: [GameName] = []
    //var gThumb: [GamePng] = []
    
    var nativeAdLoader: MANativeAdLoader?
     var nativeAd: MAAd?
     var nativeAdView: UIView?
     
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var gamesTitleText: UILabel!
    @IBOutlet weak var nativeAdContainerView: UIView!
    @IBOutlet weak var gamesBottomView: UIView!
    @IBOutlet weak var gameCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gameCollectionView.dataSource = self
        self.gameCollectionView.delegate = self
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.themeColor
        backBtn.tintColor = UIColor.white
        gamesTitleText.textColor = UIColor.white
        gamesBottomView.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = true
        
        gameCollectionView.register(UINib(nibName: "GamesCVC", bundle: nil), forCellWithReuseIdentifier: "GamesCVC")
        LoadingView.show()
        let service = service(baseURL:"https://pub.gamezop.com/v3/")
        service.getAllGames(endPoint: "games?id=WzBNFhI9B") { response, error in
            LoadingView.hide()
            if error == nil {
                self.gameList = response?.games ?? []
                DispatchQueue.main.async {
                    self.gameCollectionView.reloadData()
                }
            }else{
                print(error?.localizedDescription)
            }
        }
        gamesTitleText.text = "Spin Master Rewards"
        createNativeAd()
        
        
    }
    @IBAction func gamesBackBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension GamesListVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gameCollectionView.dequeueReusableCell(withReuseIdentifier: "GamesCVC", for: indexPath) as! GamesCVC
        cell.gameCellTextLabel.text = gameList[indexPath.item].name?.en
        let urlString = (gameList[indexPath.item].assets?.thumb)!
        cell.gameImg.sd_setImage(with: URL(string: urlString), completed: nil)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collWidth = collectionView.frame.size.width - 100
        let cellWidth = collWidth/4
        return CGSize(width: cellWidth, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gameURL = gameList[indexPath.item].url
        guard let url = URL(string: gameURL!) else { return }
            UIApplication.shared.open(url)
    }
}


extension GamesListVC : MANativeAdDelegate{

    
    
    
    
    func createNativeAd()
        {
            nativeAdLoader = MANativeAdLoader(adUnitIdentifier: "YOUR_AD_UNIT_ID")
            nativeAdLoader?.nativeAdDelegate = self
            nativeAdLoader?.loadAd()
        }
    
    func didLoadNativeAd(_ nativeAdView: MANativeAdView?, for ad: MAAd)
        {
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
            
            self.nativeAdContainerView.addSubview(nativeAdView)
            
            // Set to false if modifying constraints after adding the ad view to your layout
            nativeAdView.translatesAutoresizingMaskIntoConstraints = false
            
            // Add the native ad view to your layout
            nativeAdContainerView.addSubview(nativeAdView)
            
            // Set ad view to span width and height of container and center the ad
            nativeAdContainerView.addConstraint(NSLayoutConstraint(item: nativeAdView,
                                                                   attribute: .width,
                                                                   relatedBy: .equal,
                                                                   toItem: nativeAdContainerView,
                                                                   attribute: .width,
                                                                   multiplier: 1,
                                                                   constant: 0))
            nativeAdContainerView.addConstraint(NSLayoutConstraint(item: nativeAdView,
                                                                   attribute: .height,
                                                                   relatedBy: .equal,
                                                                   toItem: nativeAdContainerView,
                                                                   attribute: .height,
                                                                   multiplier: 1,
                                                                   constant: 0))
            nativeAdContainerView.addConstraint(NSLayoutConstraint(item: nativeAdView,
                                                                   attribute: .centerX,
                                                                   relatedBy: .equal,
                                                                   toItem: nativeAdContainerView,
                                                                   attribute: .centerX,
                                                                   multiplier: 1,
                                                                   constant: 0))
            nativeAdContainerView.addConstraint(NSLayoutConstraint(item: nativeAdView,
                                                                   attribute: .centerY,
                                                                   relatedBy: .equal,
                                                                   toItem: nativeAdContainerView,
                                                                   attribute: .centerY,
                                                                   multiplier: 1,
                                                                   constant: 0))
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
