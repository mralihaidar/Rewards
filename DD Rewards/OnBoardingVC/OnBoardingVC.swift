//
//  OnBoardingVC.swift
//  DD Rewards
//
//  Created by Ali on 23/02/2023.
//

import UIKit

class OnBoardingVC: UIViewController {
    let onBoardingImages = ["onboard1", "onboard2", "onboard3"]
    var currentPage = 0 {
        didSet {
            onBoardingPageControl.currentPage = currentPage
            if currentPage == 0 {
                self.onBoardingBackBtn.setTitle("", for: .normal)
                self.onBoardingBackBtn.isHidden = true
            } else if currentPage == 2 {
                self.onBoardingNextBtn.setTitle("Finish", for: .normal)
                self.onBoardingBackBtn.isHidden = false
            } else {
                self.onBoardingBackBtn.setTitle("Back", for: .normal)
                self.onBoardingNextBtn.setTitle("Next", for: .normal)
                self.onBoardingBackBtn.isHidden = false
            }
        }
    }
    
    
    @IBOutlet weak var onBoardingNextBtn: UIButton!
    @IBOutlet weak var onBoardingBackBtn: UIButton!
    @IBOutlet weak var onBoardingPageControl: UIPageControl!
    @IBOutlet weak var onBoardingCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.onBoardingCollection.dataSource = self
        self.onBoardingCollection.delegate = self
        // Do any additional setup after loading the view.
        onBoardingCollection.register(UINib(nibName: "OnBoardingCVC", bundle: nil), forCellWithReuseIdentifier: "OnBoardingCVC")
        onBoardingCollection.backgroundColor = UIColor.hexString(hex: "f7f8f5")
        onBoardingCollection.reloadData()
        self.view.backgroundColor = UIColor.hexString(hex: "f7f8f5")
        
    }
    
    
    @IBAction func onBoardingNextBtnPressed(_ sender: UIButton) {
        
        if currentPage == onBoardingImages.count - 1 {
            let vc = PrivacyPolicyVC(nibName: "PrivacyPolicyVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            currentPage += 1
            let indexpath = IndexPath(item: currentPage, section: 0)
            onBoardingCollection.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
        }
        
    }
    
    
    @IBAction func onBoardingBackBtnPressed(_ sender: UIButton) {
        currentPage -= 1
        let indexpath = IndexPath(item: currentPage, section: 0)
        onBoardingCollection.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
        
    }
}




extension OnBoardingVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onBoardingImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = onBoardingCollection.dequeueReusableCell(withReuseIdentifier: "OnBoardingCVC", for: indexPath) as! OnBoardingCVC
        cell.onBoardingImageView.image = UIImage(named: onBoardingImages[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width )
        
    }
    
}
