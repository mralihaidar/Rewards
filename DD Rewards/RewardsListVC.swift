//
//  ViewController.swift
//  DD Rewards
//
//  Created by Ali on 06/02/2023.
//

import UIKit

class RewardsListVC: UIViewController {


    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var rewardBackButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var rewardList:[Rewards] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        DecorateUI()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        self.navigationController?.isNavigationBarHidden = true
        let service = service(baseURL:"https://livematchscore.app/Tech-Boost/get_user_rewards.php?")
        service.getAllData(endPoint: "page_no=1&no_of_records=30&game_name=MatchMasters&android_id=ad039cb8d594575f") { response, error in
            if error == nil, response?.status == 200 {
                self.rewardList = response?.data ?? []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }else{
                error?.localizedDescription
            }
        }
    }
    func DecorateUI(){
        view.backgroundColor = UIColor.hexString(hex: "E2630B")
        rewardBackButton.tintColor = UIColor.white
        titleText.textColor = UIColor.white
    }
    @IBAction func backBtnPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
extension RewardsListVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rewardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.cellTitleLbl.text = rewardList[indexPath.row].title
        cell.cellDateLbl.text = rewardList[indexPath.row].date
        cell.topDateLbl.text = rewardList[indexPath.row].date
        
        if indexPath.row >= 1 {
            let dateSame = rewardList[(indexPath.row) - 1].date
            if rewardList[indexPath.row].date == dateSame {
                cell.topDateLbl.text = ""
            } else {
                cell.topDateLbl.text = rewardList[indexPath.row].date
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVC(nibName: "DetailVC", bundle: nil)
        let gameTitle = rewardList[indexPath.row].title
        let gameDate = rewardList[indexPath.row].date
        let gameRewardURL = rewardList[indexPath.row].reward_url
        vc.gameListTitle = gameTitle ?? ""
        vc.gameListDate = gameDate ?? ""
        vc.gameListReward = gameRewardURL ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
