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
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    func getRandomPhoto() {
        let imgManager = PHImageManager.defaultManager()
        var requestOptions = PHImageRequestOptions()
        requestOptions.synchronous = true // This is necessary to return the full image, not just a thumbnail.
        var fetchOptions = PHFetchOptions()
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

