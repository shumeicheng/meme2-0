//
//  MemeDetailViewController.swift
//  meme2-0
//
//  Created by Shu-Mei Cheng on 4/9/16.
//  Copyright © 2016 Shu-Mei Cheng. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController : UIViewController {
    
    
    @IBOutlet weak var memeImage: UIImageView!
    
    var meme: Meme!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memeImage.image = meme.afterImage
        memeImage.contentMode = .ScaleAspectFit
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController!.tabBar.hidden = false
        
    }
    
}