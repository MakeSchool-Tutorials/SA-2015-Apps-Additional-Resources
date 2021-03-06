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
    
    var photoAsset: PHAsset = PHAsset()
    
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
                println(fetchResult.count)
                var randomInt = Int(arc4random_uniform(UInt32(fetchResult.count - 1)))
                photoAsset = fetchResult.objectAtIndex(randomInt) as! PHAsset
                
                // Proceed with the request for the full image.
                imgManager.requestImageForAsset(photoAsset, targetSize: view.frame.size, contentMode: PHImageContentMode.AspectFill, options: requestOptions, resultHandler: { (image, info) in
                    
                    // Place the retrieved image in the imageView. We do this on the main thread
                    // so that the UI will update immediately.
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.imageView.image = image
                    })
                    
                })
            }
        }
    }
    
    @IBAction func deletePhoto(sender: UIButton) {
        
        // Wrap the photoAsset variable in an array so we can use deleteAssets()
        var assetToDelete = [photoAsset]
        
        PHPhotoLibrary.sharedPhotoLibrary().performChanges( {
            PHAssetChangeRequest.deleteAssets(assetToDelete)},
            completionHandler: {(success, error) in
                NSLog("\nDeleted Image -> %@", (success ? "Success":"Error!"))
                if success {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.getRandomPhoto()
                    })
                } else {
                    return
                }
        })
    }

    @IBAction func filterPhoto(sender: UIButton) {
        
        // We only have one filter in this example: sepia.
        // We set up the filter here:
        let context = CIContext(options:nil)
        let unfiltered = CIImage(image: imageView.image!)
        let filter = CIFilter(name: "CISepiaTone")
        filter.setValue(unfiltered, forKey: kCIInputImageKey)
        filter.setValue(0.5, forKey: kCIInputIntensityKey)
            
        // And apply it here.
        let originalOrientation = self.imageView.image!.imageOrientation;
        let originalScale = imageView.image!.scale
            
        let cgimg = context.createCGImage(filter.outputImage, fromRect: filter.outputImage.extent())
        
        let filtered = UIImage(CGImage: cgimg, scale: originalScale, orientation: originalOrientation)!
        imageView.image = filtered
        
    }
    
    
    @IBAction func savePhoto(sender: UIButton) {
        var imageToSave = imageView.image!
        PHPhotoLibrary.sharedPhotoLibrary().performChanges( {
            PHAssetChangeRequest.creationRequestForAssetFromImage(imageToSave)},
            completionHandler: {(success, error) in
                NSLog("\nCreated Image -> %@", (success ? "Success":"Error!"))
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var authStatus = PHPhotoLibrary.authorizationStatus()
        if authStatus != PHAuthorizationStatus.Authorized {
            PHPhotoLibrary.requestAuthorization { (handler: PHAuthorizationStatus ) -> Void in
                switch(handler) {
                case PHAuthorizationStatus.Authorized:
                    self.getRandomPhoto()
                    
                    break
                case PHAuthorizationStatus.Restricted:
                    
                    break
                case PHAuthorizationStatus.Denied:
                    break
                    
                case PHAuthorizationStatus.NotDetermined:
                    break
                    
                default:
                    break
                    
                }
            }
        } else {
            self.getRandomPhoto()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

