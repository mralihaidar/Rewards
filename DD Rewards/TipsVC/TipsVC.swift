//
//  TipsVC.swift
//  CM Rewards
//
//  Created by Umair Yousaf on 01/04/2023.
//

import UIKit

class TipsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dataArr = [
                "Daily Bonus Wheel" : " The Daily Bonus Wheel is very fun part of the game which allows the player to win some extra coins. \n \n This Daily Spin Wheel is available once in 24hrs, you can spin the wheel and claim your millions of coins daily for free. Once you collect the coins you will that the back word timer is started and then come next day and collect the coins again. \n \n You can use these coins to build villages or to buy chests from which you may get new cards depending upon the village you are on." ,
                
                   "What are Pets?" : "The pets that are seen in the game are your companion, which helps you to conquer more coins and be a Coin Master. Each pet helps you in a different way, but all of them help you to get more coins and save your village from attacking.Foxy: This is the first pet that helps you in raiding your friend’s village and digging up more coins. Tiger: This pet helps you getting more coins when you attack your opponent. Rhino: This is the best pet, if you have built your village and don’t have extra shield. Then activate rhino and he will help you from an attack to your village.",
                "Golden Card Trade" : "When you have a Golden Trade event going on, then you have ability to send and receive the golden cards from your friends. This helps you to collect the golden card and complete your card set and collect your spins and coins rewards." ,
                "Viking Quest Mission" : "When playing the Viking Quest event, you need to have billions of coins to complete the event and get 2 golden cards and 3k to 5k Free Spins depending upon what village you are playing on.",
                "Invite Friends Limit" : "There is a limit on the number of rewards that a single player can receive from the Facebook friends who are joining Coin Master. Each joining bonus you get 40 spins to 250 spins depending on the village level that you reached on."]
    let titleArr = ["Daily Bonus Wheel","What are Pets?","Golden Card Trade","Viking Quest Mission","Invite Friends Limit"]
    let desc = [
        " The Daily Bonus Wheel is very fun part of the game which allows the player to win some extra coins. \n \n This Daily Spin Wheel is available once in 24hrs, you can spin the wheel and claim your millions of coins daily for free. Once you collect the coins you will that the back word timer is started and then come next day and collect the coins again. \n \n You can use these coins to build villages or to buy chests from which you may get new cards depending upon the village you are on." ,
        " The pets that are seen in the game are your companion, which helps you to conquer more coins and be a Coin Master. \n \n Each pet helps you in a different way, but all of them help you to get more coins and save your village from attacking. \n \n Foxy: This is the first pet that helps you in raiding your friend’s village and digging up more coins. \n \n Tiger: This pet helps you getting more coins when you attack your opponent. \n \n  Rhino: This is the best pet, if you have built your village and don’t have extra shield. Then activate rhino and he will help you from an attack to your village.",
        " When you have a Golden Trade event going on, then you have ability to send and receive the golden cards from your friends. \n \n This helps you to collect the golden card and complete your card set and collect your spins and coins rewards." ,
        " When playing the Viking Quest event, you need to have billions of coins to complete the event and get 2 golden cards and 3k to 5k Free Spins depending upon what village you are playing on.",
        " There is a limit on the number of rewards that a single player can receive from the Facebook friends who are joining Coin Master. \n \n Each joining bonus you get 40 spins to 250 spins depending on the village level that you reached on."]
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.register(UINib(nibName: "TipTVC", bundle: nil), forCellReuseIdentifier: "TipTVC")
    
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TipTVC", for: indexPath) as! TipTVC
        cell.lblTitle.text = self.titleArr[indexPath.row]
//        cell.lblTitleText = self.title[indexPath.row]
//        cell.lblDescText = self.desc[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc  = TipDetailVC()
        vc.titleText = self.titleArr[indexPath.row]
        vc.descText = self.desc[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
