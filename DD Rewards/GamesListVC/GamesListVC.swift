//
//  GamesListVC.swift
//  DD Rewards
//
//  Created by Ali on 15/02/2023.
//

import UIKit
import SDWebImage
class GamesListVC: UIViewController {
    var gameList: [games] = []
   // var gName: [GameName] = []
    //var gThumb: [GamePng] = []
    
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
        
        let service = service(baseURL:"https://pub.gamezop.com/v3/")
        service.getAllGames(endPoint: "games?id=WzBNFhI9B") { response, error in
            if error == nil {
                self.gameList = response?.games ?? []
                DispatchQueue.main.async {
                    self.gameCollectionView.reloadData()
                }
            }else{
                print(error?.localizedDescription)
            }
        }
        
        
    }
    @IBAction func gamesBackBtnPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
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
