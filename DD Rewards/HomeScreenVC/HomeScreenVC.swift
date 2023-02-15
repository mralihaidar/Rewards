//
//  HomeScreenVC.swift
//  DD Rewards
//
//  Created by Ali on 14/02/2023.
//

import UIKit

class HomeScreenVC: UIViewController {

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
        homeTitleView.layer.cornerRadius = 10
        titleLabel.textColor = UIColor.white
        discLabel.textColor = UIColor.white
        
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
        let collWidth = collectionView.frame.size.width - 80
        let cellWidth = collWidth/2
        return CGSize(width: cellWidth + 35, height: cellWidth - 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "RewardsListVC") as! RewardsListVC
            self.navigationController?.pushViewController(storyboard, animated: true)
        } else {
            let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "GamesListVC") as! GamesListVC
            self.navigationController?.pushViewController(storyboard, animated: true)
        }
    }
}
