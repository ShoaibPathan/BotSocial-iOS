//
//  BSFunctions.swift
//  botsocial
//
//  Created by Aamir  on 22/03/18.
//  Copyright © 2018 AamirAnwar. All rights reserved.
//

import Foundation
import Photos
import FirebaseAuthUI
import FirebaseGoogleAuthUI

enum BSCommons {
    static func addShadowTo(view:UIView) {
        let shadowPath = UIBezierPath(rect: view.bounds)
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 6
        view.layer.shadowPath = shadowPath.cgPath
    }
    
    static func getLatestPhotoFromLibrary(completion:@escaping(_ image:UIImage?)->Void) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor.init(key: "creationDate", ascending: true)]
        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        if let lastAsset = fetchResult.lastObject {
            PHImageManager.default().requestImage(for: lastAsset, targetSize: CGSize.init(width: kLibPhotoPreviewSize, height: kLibPhotoPreviewSize), contentMode: .aspectFit, options: nil, resultHandler: { (image, info) in
                DispatchQueue.main.async {
                    completion(image)
                }
            })
        }
    }
    
    static func showLoginPage(delegate:FUIAuthDelegate) {
        let authUI = FUIAuth.defaultAuthUI()
        
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth()
        ]
        authUI?.providers = providers
        
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        authUI?.delegate = delegate
        let authViewController = authUI!.authViewController()
        if let appDelegate = UIApplication.shared.delegate {
            appDelegate.window??.rootViewController?.present(authViewController, animated: true)
        }
    }
}

//protocol UIViewControllerLoadingState {
//    var loaderOverlayView:UIView {get}
//    var loader:UIActivityIndicatorView {get}
//    func showLoader()
//    func hideLoader()
//}
//





