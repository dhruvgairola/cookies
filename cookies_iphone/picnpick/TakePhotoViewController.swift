//
//  TakePhotoViewController.swift
//  picnpick
//
//  Created by Nick Gorman (LCL) on 11/29/17.
//  Copyright © 2017 Loblaw Digital. All rights reserved.
//

import Foundation
import UIKit
import CameraManager
import OverlayKit

class TakePhotoViewController: UIViewController {
    
    let dismissButton = UIButton()
    let okButton = UIButton()
    let cameraManager = CameraManager()
    let imageView = UIImageView()
    let photoView = UIView()
    let takePhotoButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubview(photoView)
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        photoView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        photoView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        photoView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        cameraManager.addPreviewLayerToView(photoView)
        cameraManager.cameraOutputMode = .stillImage
        cameraManager.cameraOutputQuality = .medium
        cameraManager.flashMode = .off
        cameraManager.writeFilesToPhoneLibrary = false
        cameraManager.showAccessPermissionPopupAutomatically = true
        
        view.addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.setTitle("Cancel", for: .normal)
        dismissButton.setTitleColor(.white, for: .normal)
        dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        view.addSubview(takePhotoButton)
        takePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        takePhotoButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        takePhotoButton.heightAnchor.constraint(equalTo: takePhotoButton.widthAnchor).isActive = true
        takePhotoButton.layer.masksToBounds = true
        takePhotoButton.layer.cornerRadius = 50
        takePhotoButton.backgroundColor = .white
        takePhotoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        takePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        takePhotoButton.addTarget(self, action: #selector(tapTake), for: .touchUpInside)
    }
    
    @objc func tapTake() {
        cameraManager.capturePictureWithCompletion({ (image, error) -> Void in
            
            if let navCont = self.presentingViewController as? OverlayContainerController,
                let root = (navCont.contentViewController as? UINavigationController)?.topViewController as? TableViewController,
                let image = image {
                    root.processPhoto(image: image)
                self.dismissView()
            }
        })
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
}
