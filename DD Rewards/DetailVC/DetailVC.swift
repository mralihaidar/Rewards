//
//  DetailVC.swift
//  DD Rewards
//
//  Created by Ali on 06/02/2023.
//

import UIKit
import Lottie
class DetailVC: UIViewController {
    //private var animationView: LottieAnimationView?
    
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var secondSection: UIView!
    @IBOutlet weak var firstSection: UIView!
    @IBOutlet weak var sectionDiscText: UILabel!
    @IBOutlet weak var collectBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var sectionDateText: UILabel!
    @IBOutlet weak var sectionTitleText: UILabel!
    @IBOutlet weak var emojiImg: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        
        mainView.backgroundColor = UIColor.hexString(hex: "E2630B")
        backButton.tintColor = UIColor.white
        titleText.textColor = UIColor.white
        shareBtn.layer.cornerRadius = 10
        collectBtn.layer.cornerRadius = 10
        //firstSection.layer.cornerRadius = 10
        secondSection.layer.borderColor = UIColor.systemGray6.cgColor
        secondSection.layer.borderWidth = 2
        secondSection.layer.cornerRadius = 10
        secondSection.layer.shadowColor = UIColor.black.cgColor
        //secondSection.layer.shadowOpacity = 0.2
        secondSection.layer.shadowRadius = 2
        secondSection.layer.shadowOffset = CGSize(width: 0, height: 2)
        animationView.backgroundColor = UIColor.hexString(hex: "874BFF")
        animationView.layer.cornerRadius = 10
        
        setupAnimationView()
    }
    func setupAnimationView () {
        // 1. Set animation content mode
          
          animationView.contentMode = .scaleAspectFit
          
          // 2. Set animation loop mode
          
          animationView.loopMode = .loop
          
          // 3. Adjust animation speed
          
          animationView.animationSpeed = 0.5
          
          // 4. Play animation
          animationView.play()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func shareBtnPressed(_ sender: UIButton) {
    }
    @IBAction func collectBtnPressed(_ sender: UIButton) {
    }
}
