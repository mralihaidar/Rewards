//
//  AppDelegate.swift
//  DD Rewards
//
//  Created by Ali on 06/02/2023.
//

import UIKit
import AppLovinSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
                let settings = ALSdkSettings()
//                settings.consentFlowSettings.isEnabled = true
//                settings.consentFlowSettings.privacyPolicyURL = URL(string: "https://your_company_name.com/privacy_policy")
//
//                // Terms of Service URL is optional
//                settings.consentFlowSettings.termsOfServiceURL = URL(string: "https://your_company_name.com/terms_of_service")
            
                let sdk = ALSdk.shared(with: settings)!
                
                // Please make sure to set the mediation provider value to "max" to ensure proper functionality
                sdk.mediationProvider = "max"
                sdk.initializeSdk { (configuration: ALSdkConfiguration) in
                    
                }
        
        
        
        
        
        
        
        
        
        
        
        
        
//        ALSdk.shared()?.mediationProvider = "max"
//
//              ALSdk.shared()?.userIdentifier = UIDevice.current.identifierForVendor!.uuidString
//
//              ALSdk.shared()?.initializeSdk { (configuration: ALSdkConfiguration) in
//                  ALPrivacySettings.setHasUserConsent(true)
//              }
//        ALSdk.shared()?.showMediationDebugger()

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

