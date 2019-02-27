//
//  UIViewController+Alerts.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/22/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit

extension UIViewController {
    public func showAlert(title: String?, message: String?, actionTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionTitle, style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    public func showAlert(title: String?, message: String?,
                          style: UIAlertController.Style,
                          handler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "Cancel", style: .cancel)
        let customAction = UIAlertAction(title: "Submit", style: .default, handler: handler)
        alertController.addAction(okAction)
        alertController.addAction(customAction)
        present(alertController, animated: true)
    }
    
    public func showDestructionAlert(title: String?, message: String?,
                                     style: UIAlertController.Style,
                                     handler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "Cancel", style: .cancel)
        let customAction = UIAlertAction(title: "Confirm", style: .destructive, handler: handler)
        alertController.addAction(okAction)
        alertController.addAction(customAction)
        present(alertController, animated: true)
    }
    
    public func addImageAlert(_ imagePicker: UIImagePickerController!){
        let alertController = UIAlertController.init(title: "Create Connection Photo", message: nil, preferredStyle: .actionSheet)
        let takePhotoAction = UIAlertAction.init(title: "Take Photo", style: .default){(alertAction) in
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true)
        }
        let chooseFromLibraryAction = UIAlertAction.init(title: "Choose From Library", style: .default) { (alertAction) in
             imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel)
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            takePhotoAction.isEnabled = false
        }
        alertController.addAction(cancelAction)
        alertController.addAction(takePhotoAction)
        alertController.addAction(chooseFromLibraryAction)
        present(alertController, animated: true)
    }
    
}
