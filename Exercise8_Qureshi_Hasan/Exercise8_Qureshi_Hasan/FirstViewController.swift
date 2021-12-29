//
//  FirstViewController.swift
//  Exercise8_Qureshi_Hasan
//
//  Created by Hasan Qureshi on 11/11/21.
//  Copyright © 2021 Hasan Qureshi. All rights reserved.
//


import UIKit
import CoreML
import Vision

class FirstViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var result: UILabel!
    
    var images = [1:"cat", 2: "computer", 3: "fountain", 4: "kitchen", 5: "lake", 6: "market", 7: "mountain"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        classifyImage()
    }

    @IBAction func shuffleBtn(_ sender: Any) {
        var random = Int.random(in: 1 ... 5)
        imgView.image = UIImage(named: images[random]!)
        classifyImage()
    }
    
    func classifyImage(){
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else {
            print("Failed to load ML Model")
            return
        }
        guard let ciImage = CIImage(image: imgView.image!) else {
            print("Failed to convert image to CIImage")
            return
        }
        
        // weak self memory management, it will be removed if not needed
        let request = VNCoreMLRequest(model: model) {
            [weak self] request, error in
            // array of results
            let results = request.results as? [VNClassificationObservation]
            
            var classificationResultText = ""
            
            for result in results! {
                classificationResultText += "\(Int(result.confidence*100))% of \(result.identifier)\n"
            }
            // print(classificationResultText)
            DispatchQueue.main.async {
                self?.result.text = classificationResultText
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage)
        // qos: quality of service
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
        }
    }

}

