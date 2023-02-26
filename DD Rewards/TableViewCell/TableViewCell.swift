//
//  TableViewCell.swift
//  DD Rewards
//
//  Created by Ali on 06/02/2023.
//

import UIKit
import AppLovinSDK

class TableViewCell: UITableViewCell {
    
    
    var nativeAdLoader: MANativeAdLoader?
    var nativeAd: MAAd?
    var nativeAdView: UIView?
    
    @IBOutlet weak var topDateLbl: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var TVCell: UIView!
    @IBOutlet weak var cellBackArrow: UIButton!
    @IBOutlet weak var cellDateLbl: UILabel!
    @IBOutlet weak var cellTitleLbl: UILabel!
    @IBOutlet weak var cellImg: UIImageView!
    @IBOutlet weak var nativeAdContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellImg.layer.borderWidth = 1
        cellImg.layer.borderColor = UIColor.themeColor.cgColor
        cellImg.layer.cornerRadius = 10
        //cellView.layer.borderWidth = 1
        cellView.layer.cornerRadius = 10
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOpacity = 0.23
        cellView.layer.shadowRadius = 2
        cellView.layer.shadowOffset = CGSize(width: 0, height: 2)
//        cellBackArrow.tintColor = UIColor.themeColor
        //topDateLbl.text = ""
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension TableViewCell: MANativeAdDelegate
{
  
    
    func createNativeAd()
       {
           nativeAdLoader = MANativeAdLoader(adUnitIdentifier: "YOUR_AD_UNIT_ID")
           nativeAdLoader?.nativeAdDelegate = self
           nativeAdLoader?.loadAd()
       }
    
    func didLoadNativeAd(_ nativeAdView: MANativeAdView?, for ad: MAAd)
    {
        // Clean up any pre-existing native ad to prevent memory leaks
        if let currentNativeAd = nativeAd
        {
            nativeAdLoader?.destroy(currentNativeAd)
        }

        // Save ad for cleanup
        nativeAd = ad
        
        if let currentNativeAdView = self.nativeAdView
        {
            currentNativeAdView.removeFromSuperview()
        }
        
        // Add ad view to view
        self.nativeAdView = nativeAdView;
        guard let nativeAdView = nativeAdView else { return }
        self.nativeAdContainerView.addSubview(nativeAdView)
        
        // Set to false if modifying constraints after adding the ad view to your layout
        nativeAdView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the native ad view to your layout
        nativeAdContainerView.addSubview(nativeAdView)
        
        // Set ad view to span width and height of container and center the ad
        nativeAdContainerView.addConstraint(NSLayoutConstraint(item: nativeAdView,
                                                               attribute: .width,
                                                               relatedBy: .equal,
                                                               toItem: nativeAdContainerView,
                                                               attribute: .width,
                                                               multiplier: 1,
                                                               constant: 0))
        nativeAdContainerView.addConstraint(NSLayoutConstraint(item: nativeAdView,
                                                               attribute: .height,
                                                               relatedBy: .equal,
                                                               toItem: nativeAdContainerView,
                                                               attribute: .height,
                                                               multiplier: 1,
                                                               constant: 0))
        nativeAdContainerView.addConstraint(NSLayoutConstraint(item: nativeAdView,
                                                               attribute: .centerX,
                                                               relatedBy: .equal,
                                                               toItem: nativeAdContainerView,
                                                               attribute: .centerX,
                                                               multiplier: 1,
                                                               constant: 0))
        nativeAdContainerView.addConstraint(NSLayoutConstraint(item: nativeAdView,
                                                               attribute: .centerY,
                                                               relatedBy: .equal,
                                                               toItem: nativeAdContainerView,
                                                               attribute: .centerY,
                                                               multiplier: 1,
                                                               constant: 0))
    }
    
    func didFailToLoadNativeAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError)
    {
        // We recommend retrying with exponentially higher delays up to a maximum delay
    }
    
    func didClickNativeAd(_ ad: MAAd)
    {
        // Optional click callback
    }
}
