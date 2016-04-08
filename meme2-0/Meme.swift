//
//  Meme.swift
//  meme2-0
//
//  Created by Shu-Mei Cheng on 4/1/16.
//  Copyright © 2016 Shu-Mei Cheng. All rights reserved.
//

import Foundation
import UIKit

struct  Meme {
    var topText:String
    var bottomText:String
    var afterImage:UIImage
    
    var originalImage:UIImage
    
    init(topText:String, bottomText:String, originalImage:UIImage, afterImage:UIImage){
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.afterImage = afterImage
        
    }
}