//
//  UserDefaultsManager.swift
//  DD Rewards
//
//  Created by Umair Yousaf on 24/02/2023.
//

import Foundation






extension UserDefaults {
    
    var PrivacyPolicyAccept : String? {
        get {
            
            return string(forKey: "PrivacyPolicyAccept")
        }
        set {
            set(1, forKey: "PrivacyPolicyAccept")
        }
    }
    
    
    
}



