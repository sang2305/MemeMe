//
//  Meme.swift
//  MemeMe_Final
//
//  Created by Praveen Ramanathan on 6/22/15.
//  Copyright (c) 2015 Sangeetha. All rights reserved.
//

import Foundation
import UIKit

class Meme{
    var top : String
    var bottom : String
    var image : UIImage
    var memedImage : UIImage!
    
    init(toptext: String, bottomtext: String, image: UIImage, memedImage: UIImage){
        self.top = toptext
        self.bottom = bottomtext
        self.image = image
        self.memedImage = memedImage
    }
}


