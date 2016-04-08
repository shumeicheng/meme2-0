//
//  MemeViewController.swift
//  meme2-0
//
//  Created by Shu-Mei Cheng on 4/1/16.
//  Copyright © 2016 Shu-Mei Cheng. All rights reserved.
//

import Foundation
import UIKit

class MemeViewController : UIViewController {
    
    var meme: Meme!
    
    @IBOutlet weak var memeImage: UIImageView!
    
    override func viewWillAppear( animated: Bool){
        super.viewWillAppear(animated)
        
        memeImage.image = meme.originalImage
        
    }
}