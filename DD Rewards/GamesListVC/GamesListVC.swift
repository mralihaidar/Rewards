//
//  GamesListVC.swift
//  DD Rewards
//
//  Created by Ali on 15/02/2023.
//

import UIKit

class GamesListVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var gamesTitleText: UILabel!
    @IBOutlet weak var gamesUpperView: UIView!
    @IBOutlet weak var gamesBottomView: UIView!
    @IBOutlet weak var gameCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gameCollectionView.dataSource = self
        self.gameCollectionView.delegate = self
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.hexString(hex: "E2630B")
        backBtn.tintColor = UIColor.white
        gamesTitleText.textColor = UIColor.white
        gamesBottomView.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = true
        
        gameCollectionView.register(UINib(nibName: "GamesCVC", bundle: nil), forCellWithReuseIdentifier: "GamesCVC")
    }
    @IBAction func gamesBackBtnPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
extension GamesListVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gameCollectionView.dequeueReusableCell(withReuseIdentifier: "GamesCVC", for: indexPath) as! GamesCVC
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collWidth = collectionView.frame.size.width - 50
        let cellWidth = collWidth/4
        return CGSize(width: cellWidth, height: 110)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
