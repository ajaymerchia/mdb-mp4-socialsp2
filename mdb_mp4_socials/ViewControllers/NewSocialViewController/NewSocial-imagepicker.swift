//
//  NewSocial-imagepicker.swift
//  
//
//  Created by Ajay Raj Merchia on 9/27/18.
//

import Foundation
import UIKit

extension NewSocialViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func openActionSheet() {
        let actionSheet = UIAlertController(title: "Select Photo From", message: "", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) -> Void in
            self.createImagePicker(preferredType: .camera)
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { (action) -> Void in
            self.createImagePicker(preferredType: .photoLibrary)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true)
        
    }
    
    @objc func createImagePicker(preferredType: UIImagePickerController.SourceType) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            picker.sourceType = preferredType
            picker.allowsEditing = true
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(picker, animated: true, completion: nil)
        }
        else {
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
            
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){

        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        eventImgPicker.setImage(chosenImage, for: .normal)
        imgPickerPrompt.removeFromSuperview()
        dismiss(animated:true, completion: nil)
    }


    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    

}
