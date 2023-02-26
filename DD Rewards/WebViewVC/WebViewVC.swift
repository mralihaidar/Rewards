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
    
    @IBOutlet weak var lblTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        
        super.viewWillAppear(animated)
        guard let link = URL(string:self.webLink) else { return  }
        let request = URLRequest(url: link)
        webView.load(request)

    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
}
