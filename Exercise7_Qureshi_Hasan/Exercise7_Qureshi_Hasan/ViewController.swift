//
//  ViewController.swift
//  Exercise7_Qureshi_Hasan
//
//  Created by Hasan Qureshi on 11/4/21.
//  Copyright © 2021 Hasan Qureshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    let picker = UIImagePickerController()
    var picture = UIImage()
    let context = CIContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picture = UIImage(named: "houston") ?? UIImage()
    }
    
    @IBAction func selectPhoto(_ sender: Any) {
        // initialize the alert
        let actionAlert = UIAlertController(title: "Photo Source Picker", message:"" , preferredStyle: .actionSheet)

         actionAlert.addAction(UIAlertAction(title: "Open Camera", style: .default, handler: { _ in
             if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.picker.allowsEditing = false
                self.picker.sourceType = .camera
                self.picker.cameraCaptureMode = .photo

                self.present(self.picker, animated: true, completion: nil)
             } else {
                 print("Camera is not available!")
                 
             }
         }))
        
        // add Open Gallery option
         actionAlert.addAction(UIAlertAction(title: "Open Gallery", style: .default, handler: { _ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.picker.allowsEditing = false
                self.picker.sourceType = .photoLibrary
                self.present(self.picker, animated: true, completion: nil)
                // info.plist just add Privacy - Photo Library Usage, no right side content
            }
         }))
        
        // add dismiss alert
        actionAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        
        
        self.present(actionAlert, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else{
            return print("Error in picking/converting image!")
        }
        
        imageView.image = selectedImage
        picture = selectedImage
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func filterImage(_ sender: UISegmentedControl) {
        if imageView.image != nil
        {
            if sender.selectedSegmentIndex == 0 {
                imageView.image = picture
                
            } else if sender.selectedSegmentIndex == 1 {
                if let filteredImage = filterSelectedImage(filterType: "CIGaussianBlur") {
                    imageView.image = filteredImage
                }
            }
            else if sender.selectedSegmentIndex == 2 {
                if let filteredImage = filterSelectedImage(filterType: "CISepiaTone") {
                    imageView.image = filteredImage
                }
            }
            else if sender.selectedSegmentIndex == 3 {
                if let filteredImage = filterSelectedImage(filterType: "CIPhotoEffectInstant") {
                    imageView.image = filteredImage
                }
            }
            else if sender.selectedSegmentIndex == 4 {
                if let filteredImage = filterSelectedImage(filterType: "CIPhotoEffectNoir") {
                    imageView.image = filteredImage
                }
            }
        }
    }
    
    func filterSelectedImage(filterType: String) -> UIImage? {
        var inputImg = self.picture
        let inputCIImage = CIImage(image: inputImg)
        let filter = CIFilter(name: filterType, parameters: ["inputImage": inputCIImage!])
        let outputImage = filter?.outputImage
        let cgImage = context.createCGImage(outputImage!, from: outputImage!.extent)
        
        return UIImage(cgImage: cgImage!, scale: inputImg.scale, orientation: inputImg.imageOrientation)
    }
    
    @IBAction func savePhoto(_ sender: Any) {
        // Privacy - Photo Library Additions Usage Description (NSPhotoLibraryAddUsageDescription)
        UIImageWriteToSavedPhotosAlbum(imageView.image!, nil ,nil , nil)
        
        let alert = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photo gallery", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }



}

