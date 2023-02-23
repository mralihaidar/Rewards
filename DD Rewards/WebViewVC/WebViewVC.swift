//
//  WebViewVC.swift
//  DD Rewards
//
//  Created by Umair Yousaf on 24/02/2023.
//

import UIKit
import WebKit

class WebViewVC: UIViewController {

    var webLink : String!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.navigationBar.isHidden = false
        
       
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        
        super.viewWillAppear(animated)
        guard let link = URL(string:self.webLink) else { return  }
        let request = URLRequest(url: link)
        webView.load(request)
        
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
