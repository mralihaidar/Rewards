//
//  ViewController.swift
//  DD Rewards
//
//  Created by Ali on 06/02/2023.
//

import UIKit
import AppLovinSDK

class RewardsListVC: UIViewController {
    
    let deviceID = UIDevice.current.identifierForVendor!.uuidString
    var pageNum = 1
    var interstitialAd: MAInterstitialAd!
    var retryAttempt = 0.0
    
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
        
        
        getRewards()
        if (ProcessUtils.shared.IsAddShow == true){
            createInterstitialAd()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    func DecorateUI(){
        view.backgroundColor = UIColor.themeColor
        rewardBackButton.tintColor = UIColor.white
        titleText.textColor = UIColor.white
        titleText.text = "Daily Spin & Coins Link"
    }
    
    func getRewards(){
        
        LoadingView.show()
        let service = service(baseURL:"https://livematchscore.app/Tech-Boost/get_user_rewards.php?")
        service.getAllData(endPoint: "page_no=\(self.pageNum)&no_of_records=30&game_name=CoinMaster&android_id=\(self.deviceID)") { response, error in
            LoadingView.hide()
            if error == nil, response?.status == 200 {
                if (self.rewardList.count == 0 ){
                    self.rewardList = response?.data ?? []
                }else{
                    self.rewardList.append(contentsOf: response?.data ?? [])
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }else{
                error?.localizedDescription
            }
        }
        
        self.pageNum += 1
        
    }
    
    func updateRewards( data: Rewards){
        
        let vc = DetailVC(nibName: "DetailVC", bundle: nil)
        vc.setContent(dataModel: data)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}





extension RewardsListVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rewardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.cellTitleLbl.text = rewardList[indexPath.row].title
        
        let dateFormate = DateFormatManager.shared.formatDateStrToStr(date: rewardList[indexPath.row].date ?? "", oldFormat: "dd-MM-yy", newFormat: "dd MMM yyyy")
        if (rewardList[indexPath.row].date != nil) {
            cell.cellDateLbl.text = dateFormate
            cell.topDateLbl.text = dateFormate
        }else{
            
            cell.cellDateLbl.text = ""
            cell.topDateLbl.text = ""
        }
        
        
        if (rewardList[indexPath.row].is_opened == "1"){
            cell.cellBackArrow.tintColor = UIColor.lightGray
        }else{
            cell.cellBackArrow.tintColor = UIColor.themeColor
        }
        
        if indexPath.row >= 1 {
            let dateSame = rewardList[(indexPath.row) - 1].date
            if rewardList[indexPath.row].date == dateSame {
                cell.topDateLbl.text = ""
            } else {
                cell.topDateLbl.text = rewardList[indexPath.row].date
            }
        }
        if (ProcessUtils.shared.IsAddShow == true){
            if indexPath.row == 0 {
                cell.createNativeAd()
                cell.nativeAdContainerView.isHidden = false
            }else{
                cell.nativeAdContainerView.isHidden = true
            }
        }else{
            cell.nativeAdContainerView.isHidden = true
        }
        
        
        if (indexPath.row > rewardList.count - 5  && (self.rewardList.count % 30) == 0){
            self.getRewards()
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if (ProcessUtils.shared.IsAddShow == false){
            if rewardList[indexPath.row].is_opened != "1" {
                if self.rewardList[indexPath.row].is_opened != "1" {
                    
                    let param =  [ "android_id" : self.deviceID, "platform" : "ios", "reward_id" : self.rewardList[indexPath.row].id ?? "" ] as [String : Any]
                    LoadingView.show()
                    let service = service(baseURL:"https://livematchscore.app/Tech-Boost/update_reward_views.php")
                    service.postRequestWithURL(UrlPath: "https://livematchscore.app/Tech-Boost/update_reward_views.php",params: param) { response, error in
                        LoadingView.hide()
                    }
                    self.rewardList[indexPath.row].is_opened = "1";
                }
                
                self.updateRewards(data: self.rewardList[indexPath.row] )
            }else{
                self.updateRewards(data: self.rewardList[indexPath.row] )
            }
                
        }else{
            if rewardList[indexPath.row].is_opened != "1" {
                
                let alert = UIAlertController(title: "Alert", message: "You are about to see interstitial ads. Which is also known as full screen ads", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "No Thanks", style: .default, handler: { action in
                    return
                }))
                
                alert.addAction(UIAlertAction(title: "Watch Ad", style: .default, handler: { action in
                    
                        if self.interstitialAd.isReady
                        {
                            self.interstitialAd.show()
                        }
                    
                    if self.rewardList[indexPath.row].is_opened != "1" {
                        
                        let param =  [ "android_id" : self.deviceID, "platform" : "ios", "reward_id" : self.rewardList[indexPath.row].id ?? "" ] as [String : Any]
                        LoadingView.show()
                        let service = service(baseURL:"https://livematchscore.app/Tech-Boost/update_reward_views.php")
                        service.postRequestWithURL(UrlPath: "https://livematchscore.app/Tech-Boost/update_reward_views.php",params: param) { response, error in
                            LoadingView.hide()
                        }
                        self.rewardList[indexPath.row].is_opened = "1";
                    }
                    
                    self.updateRewards(data: self.rewardList[indexPath.row] )
                }))
                
                self.present(alert, animated: true, completion: nil)
                
            }else{
                
                let alert = UIAlertController(title: "Alert", message: "You are about to see interstitial ads. Which is also known as full screen ads", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "No Thanks", style: .default, handler: { action in
                    return
                }))
                
                alert.addAction(UIAlertAction(title: "Watch Ad", style: .default, handler: { action in
                    if (ProcessUtils.shared.IsAddShow == true){
                        if self.interstitialAd.isReady
                        {
                            self.interstitialAd.show()
                        }
                    }
                    
                    self.updateRewards(data: self.rewardList[indexPath.row] )
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
}


extension RewardsListVC :  MAAdDelegate
{


    func createInterstitialAd()
    {
        interstitialAd = MAInterstitialAd(adUnitIdentifier: "YOUR_AD_UNIT_ID")
        interstitialAd.delegate = self

        // Load the first ad
        interstitialAd.load()
    }

    // MARK: MAAdDelegate Protocol

    func didLoad(_ ad: MAAd)
    {
        // Interstitial ad is ready to be shown. 'interstitialAd.isReady' will now return 'true'
        
        // Reset retry attempt
        retryAttempt = 0
    }

    func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError)
    {
        // Interstitial ad failed to load
        // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
        
        retryAttempt += 1
        let delaySec = pow(2.0, min(6.0, retryAttempt))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delaySec) {
            self.interstitialAd.load()
        }
    }

    func didDisplay(_ ad: MAAd) {}

    func didClick(_ ad: MAAd) {}

    func didHide(_ ad: MAAd)
    {
        // Interstitial ad is hidden. Pre-load the next ad
        interstitialAd.load()
    }

    func didFail(toDisplay ad: MAAd, withError error: MAError)
    {
        // Interstitial ad failed to display. We recommend loading the next ad
        interstitialAd.load()
    }
}
