//
//  UserDefaultsManager.swift
//  DD Rewards
//
//  Created by Umair Yousaf on 24/02/2023.
//

import Foundation
import UIKit






extension UserDefaults {
    
    var deviceID : String? {
        get {
            
            return string(forKey: "deviceID")
        }
        set {
            set("\(UIDevice.current.identifierForVendor!.uuidString)", forKey: "deviceID")
        }
}
    
    var PrivacyPolicyAccept : String? {
        get {
            
            return string(forKey: "PrivacyPolicyAccept")
        }
        set {
            set(1, forKey: "PrivacyPolicyAccept")
        }
    }
    
    var isConsentShow : String? {
        get {
            
            return string(forKey: "isConsentShow")
        }
        set {
            set("1", forKey: "isConsentShow")
        }
    }
    
}



