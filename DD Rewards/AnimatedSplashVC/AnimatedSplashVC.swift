//
//  AnimatedSplashVC.swift
//  DD Rewards
//
//  Created by Umair Yousaf on 26/02/2023.
//

import UIKit
import Lottie


class AnimatedSplashVC: UIViewController {

    
    
    @IBOutlet weak var homeAnimation: LottieAnimationView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimationView ()
        // Do any additional setup after loading the view.
    }

    func setupAnimationView () {
//        homeAnimation = LottieAnimationView(name: "coin")
        homeAnimation.contentMode = .scaleAspectFit
        homeAnimation.loopMode = .loop
        homeAnimation.animationSpeed = 0.7
        homeAnimation.play()
    }
  
}
