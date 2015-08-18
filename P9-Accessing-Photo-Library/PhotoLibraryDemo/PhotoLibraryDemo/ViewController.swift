//
//  ViewController.swift
//  PhotoLibraryDemo
//
//  Created by Samara Trilling on 8/18/15.
//  Copyright (c) 2015 Samara Trilling. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var photoAsset : PHAsset = PHAsset()
    
    func getRandomPhoto() {
        // Set up the infrastructure for the request.
        let imgManager = PHImageManager.defaultManager()
        var requestOptions = PHImageRequestOptions()
        requestOptions.synchronous = true // This is necessary to return the full image, not just a thumbnail.
        var fetchOptions = PHFetchOptions()
        
        
        // Make the request to the phone's photo library.
        if let fetchResult = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: fetchOptions) {
            
            // Make sure fetchResult is not an empty array.
            if (fetchResult.count > 0) {
                
                // Create a random number, then choose the image at that random index.
                var randomInt = Int(arc4random_uniform(UInt32(fetchResult.count)))
                let photoAsset = fetchResult[randomInt] as! PHAsset!
                
                // Proceed with the request for the full image.
                imgManager.requestImageForAsset(photoAsset, targetSize: view.frame.size, contentMode: PHImageContentMode.AspectFill, options: requestOptions, resultHandler: { (image, info) in
                    
                        // Place the retrieved image in the imageView.
                        self.imageView.image = image
                    
                })

            }
            
        }
        
    }
    
    @IBAction func deletePhoto(sender: UIButton) {
    }
    
    @IBAction func filterPhoto(sender: UIButton) {
    }
    
    
    @IBAction func savePhoto(sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.getRandomPhoto()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

