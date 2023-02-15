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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        DecorateUI()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        self.navigationController?.isNavigationBarHidden = true
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
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
       // cell.labelText = "50 Spins Plus Coins"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVC(nibName: "DetailVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
